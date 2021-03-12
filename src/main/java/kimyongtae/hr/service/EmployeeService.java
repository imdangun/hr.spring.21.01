package kimyongtae.hr.service;

import java.time.LocalDate;
import java.util.List;

import kimyongtae.hr.domain.Employee;

public interface EmployeeService {
	List<Employee> getEmployees();
	int addEmployee(String empName, LocalDate hireDate);
	int fixEmployee(Employee emp);
	int delEmployee(int empId);
}
