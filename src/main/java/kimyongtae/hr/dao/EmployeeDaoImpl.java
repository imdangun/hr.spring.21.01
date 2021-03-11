package kimyongtae.hr.dao;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kimyongtae.hr.dao.map.EmployeeMap;
import kimyongtae.hr.domain.Employee;

@Repository
public class EmployeeDaoImpl implements EmployeeDao {
	@Autowired private EmployeeMap empMap;
	
	@Override
	public List<Employee> selectEmployees() {
		return empMap.selectEmployees();
	}
	
	@Override
	public Employee selectEmployee(int empId) {
		return empMap.selectEmployee(empId);
	}
	
	@Override
	public int insertEmployee(String empName, LocalDate hireDate) {
		return empMap.insertEmployee(empName, hireDate);
	}
	
	@Override
	public int updateEmployee(Employee emp) {
		return empMap.updateEmployee(emp);
	}
	
	@Override
	public int deleteEmployee(int empId) {
		return empMap.deleteEmployee(empId);
	}
}
