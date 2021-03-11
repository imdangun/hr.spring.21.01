package kimyongtae.hr.dao;

import java.time.LocalDate;
import java.util.List;

import kimyongtae.hr.domain.Employee;

public interface EmployeeDao {
	List<Employee> selectEmployees();
	Employee selectEmployee(int empId);
	int insertEmployee(String empName, LocalDate hireDate);
	int updateEmployee(Employee emp);
	int deleteEmployee(int empId);
}
