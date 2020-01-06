package cn.geek51.service.impl;

import cn.geek51.dao.DepartmentDao;
import cn.geek51.domain.Department;
import cn.geek51.service.IDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DepartmentServiceImpl extends BaseServiceImpl<Department> implements IDepartmentService {
}
