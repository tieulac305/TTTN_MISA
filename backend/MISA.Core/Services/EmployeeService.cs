using MISA.Core.Entities;
using MISA.Core.Interfaces.Infrastructure;
using System;
using System.Collections.Generic;
using System.Text;
using MISA.Core.Interfaces.Service;
using MISA.Core.Enums;
using System.Text.RegularExpressions;

namespace MISA.Core.Services
{
    public class EmployeeService : BaseService<Employee>, IEmployeeService
    {
        #region Fields

        /// <summary>
        /// repo thực hiện giao tiếp với dữ liệu
        /// </summary>
        private IEmployeeRepository employeeRepository;

        /// <summary>
        /// repo để check khóa ngoại
        /// </summary>
        private IDepartmentRepository departmentRepository;

        #endregion Fields

        #region Constructor

        /// <summary>
        /// khởi tạo
        /// </summary>
        /// <param name="_employeeRepository">repo nhân viên</param>
        /// <param name="_departmentRepository">repo phòng ban/đơn vị</param>
        /// Author: CpNam 17.08.2021
        public EmployeeService(IEmployeeRepository _employeeRepository, IDepartmentRepository _departmentRepository) : base(_employeeRepository) {
            employeeRepository = _employeeRepository;
            departmentRepository = _departmentRepository;
        }

        #endregion Constructor

        #region Methods

        /// <summary>
        /// kiểm tra dữ liệu nhân viên
        /// </summary>
        /// <param name="employee"></param>
        /// Author: CpNam 06.08.2021
        protected override bool ValidateCustom(Employee employee, ref ServiceResult serviceResult) {
            bool isValid = true;

            // kiểm tra xem email có đúng không
            /*if (!string.IsNullOrEmpty(employee.Email) && !new Regex(@"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").IsMatch(employee.Email)) {
                serviceResult.MISACode = MISACode.Invalid;
                serviceResult.Data = "Email";
                serviceResult.Messenger = Resources.Employee.ValidateError_Email;
                isValid = false;
            }*/

            //kiểm tra xem khóa ngoại có tồn tại không
            if (departmentRepository.GetById(employee.DepartmentId) == null) {
                serviceResult.MISACode = MISACode.Invalid;
                serviceResult.Data = "DepartmentId";
                serviceResult.Messenger = Resources.Employee.ValidateError_DepartmentNotExists;
                isValid = false;
            }

            // kiểm tra xem mã nhân viên có trùng không nếu là thêm
            // nếu trùng thì xem id như cũ thì là sửa vẫn đc, k thì invalid
            Employee emp = employeeRepository.GetByCode(employee.EmployeeCode);

            if (emp != null && employee.EmployeeId != emp.EmployeeId) {
                serviceResult.MISACode = MISACode.Invalid;
                serviceResult.Data = "EmployeeCode";
                serviceResult.Messenger = Resources.Employee.ValidateError_EmployeeCodeDuplicate;
                isValid = false;
            }

            return isValid;
        }

        /// <summary>
        /// lấy mã nhân viên mới
        /// </summary>
        /// Author: CpNam 06.08.2021
        public ServiceResult GetNewEmployeeCode() {
            ServiceResult serviceResult = new ServiceResult();

            serviceResult.Data = employeeRepository.GetNewEmployeeCode();
            serviceResult.MISACode = MISACode.Success;

            return serviceResult;
        }

        /// <summary>
        /// lấy ra danh sách nhân viên theo bộ lọc và trang yêu cầu
        /// </summary>
        /// <param name="employeeFilter">mã, tên, sdt</param>
        /// <param name="pageIndex">số trang</param>
        /// <param name="pageSize">kích thước trang</param>
        /// Author: CpNam 17.08.2021
        public ServiceResult GetEmployeesFilterPaging(string employeeFilter, int pageIndex, int pageSize) {
            ServiceResult serviceResult = new ServiceResult();

            if (!string.IsNullOrEmpty(employeeFilter)) employeeFilter = employeeFilter.Trim();
            serviceResult.Data = employeeRepository.GetEmployeesFilterPaging(employeeFilter, pageIndex, pageSize);
            serviceResult.MISACode = MISACode.Success;

            return serviceResult;
        }

        /// <summary>
        /// Xóa nhiều nhân viên
        /// </summary>
        /// <param name="employeeList"></param>
        /// <returns></returns>
        public ServiceResult DeleteEmployees(List<Guid> employeeList) {
            ServiceResult serviceResult = new ServiceResult();

            int affectedRows = employeeRepository.DeleteEmployees(employeeList);

            serviceResult.MISACode = MISACode.Success;
            serviceResult.Data = affectedRows;

            if (affectedRows == 0) {
                serviceResult.MISACode = MISACode.Invalid;
                serviceResult.Messenger = Resources.Common.ResponseError_Exception;
            }

            return serviceResult;
        }

        #endregion Methods
    }
}