using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using MISA.Core.Entities;
using MISA.Core.Enums;
using MISA.Core.Interfaces.Service;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace MISA.AMIS.API.Controllers
{
    [ApiController]
    public class EmployeesController : BaseEntityController<Employee>
    {
        #region Fields

        /// <summary>
        /// service cho nhân viên
        /// </summary>
        private IEmployeeService employeeService;

        #endregion Fields

        #region Constructor

        /// <summary>
        /// khởi tạo service
        /// </summary>
        /// Author: CpNam 17.08.2021
        public EmployeesController(IEmployeeService employeeService) : base(employeeService) {
            this.employeeService = employeeService;
        }

        #endregion Constructor

        #region Methods

        /// <summary>
        /// api lấy mã nhân viên mới
        /// </summary>
        /// <returns>mã nv mới</returns>
        /// Author: CpNam 17.08.2021
        [HttpGet("newCode")]
        public IActionResult GetNewEmployeeCode() {
            try {
                ServiceResult serviceResult = employeeService.GetNewEmployeeCode();
                return Ok(serviceResult);
            }
            catch (Exception) {
                return ExceptionResult();
            }
        }

        /// <summary>
        /// hàm phân trang và lọc nhân viên
        /// </summary>
        /// <param name="employeeFilter">chuỗi tìm kiếm</param>
        /// <param name="pageIndex">trang cần lấy</param>
        /// <param name="pageSize">kích thước trang</param>
        /// Author: CpNam 17.08.2021
        [HttpGet("employeeFilterPaging")]
        public IActionResult GetEmployeesFilterPaging([FromQuery] string employeeFilter, [FromQuery] int pageIndex, [FromQuery] int pageSize) {
            try {
                ServiceResult serviceResult = employeeService.GetEmployeesFilterPaging(employeeFilter, pageIndex, pageSize);
                return Ok(serviceResult);
            }
            catch (Exception) {
                return ExceptionResult();
            }
        }

        [HttpDelete]
        public IActionResult DeleteEmployees([FromBody] List<Guid> emps) {
            try {
                ServiceResult serviceResult = employeeService.DeleteEmployees(emps);
                return Ok(serviceResult);
            }
            catch (Exception) {
                return ExceptionResult();
            }
        }

        #endregion Methods
    }
}