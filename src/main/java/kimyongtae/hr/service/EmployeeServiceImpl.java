package kimyongtae.hr.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kimyongtae.hr.dao.EmployeeDao;
import kimyongtae.hr.domain.Employee;

@Service
public class EmployeeServiceImpl implements EmployeeService {
	@Autowired private EmployeeDao empDao;
	
	@Override
	public List<Employee> getEmployees() {
		return empDao.selectEmployees();
	}	
	
	@Override
	public int addEmployee(String empName, LocalDate hireDate) {
		return empDao.insertEmployee(empName, hireDate);
	}
	
	@Override
	public int fixEmployee(Employee emp) {
		return empDao.updateEmployee(emp);
	}
	
	@Override
	public int delEmployee(int empId) {
		return empDao.deleteEmployee(empId);
	}
}
