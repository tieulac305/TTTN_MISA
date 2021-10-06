using MISA.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace MISA.Core.Interfaces.Infrastructure
{
    public interface IEmployeeRepository : IBaseRepository<Employee>
    {
        /// <summary>
        /// Lấy mã nhân viên
        /// </summary>
        /// <returns>mã mới</returns>
        /// Author: CpNam 05.08.2021
        public string GetNewEmployeeCode();

        /// <summary>
        /// lấy ra danh sách nhân viên theo bộ lọc và trang yêu cầu
        /// </summary>
        /// <param name="employeeFilter">mã, tên, sdt</param>
        /// <param name="pageIndex">số trang</param>
        /// <param name="pageSize">kích thước trang</param>
        /// Author: CpNam 05.08.2021
        public object GetEmployeesFilterPaging(string employeeFilter, int pageIndex, int pageSize);

        /// <summary>
        /// xóa nhiều nhân viên
        /// </summary>
        /// <param name="employeeList">danh sách Id</param>
        /// <returns></returns>
        public int DeleteEmployees(List<Guid> employeeList);
    }
}