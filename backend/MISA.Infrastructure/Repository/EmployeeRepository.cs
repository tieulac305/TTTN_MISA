using Dapper;
using Microsoft.Extensions.Configuration;
using MISA.Core.Entities;
using MISA.Core.Interfaces.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace MISA.Infrastructure.Repository
{
    public class EmployeeRepository : BaseRepository<Employee>, IEmployeeRepository
    {
        #region Constructor

        /// <summary>
        /// khởi tạo
        /// </summary>
        /// Author: CpNam 17.08.2021
        public EmployeeRepository(IConfiguration _configuration) : base(_configuration) {
        }

        #endregion Constructor

        #region Methods

        /// <summary>
        /// lấy mã nhân viên mới
        /// </summary>
        /// <returns>mã mới</returns>
        /// Author: CpNam 05.08.2021
        public string GetNewEmployeeCode() {
            string sqlCommandString = $"Proc_GetNewEmployeeCode";

            return DbConnection.QueryFirstOrDefault<string>(sqlCommandString, commandType: CommandType.StoredProcedure);
        }

        /// <summary>
        /// lấy ra danh sách nhân viên theo bộ lọc và trang yêu cầu
        /// </summary>
        /// <param name="employeeFilter">mã, tên, sdt</param>
        /// <param name="pageIndex">số trang</param>
        /// <param name="pageSize">kích thước trang</param>
        /// Author: CpNam 17.08.2021
        public object GetEmployeesFilterPaging(string employeeFilter, int pageIndex, int pageSize) {
            string sqlCommandString = $"Proc_GetEmployeesFilterPaging";

            DynamicParameters param = new DynamicParameters();
            param.Add("@EmployeeFilter", employeeFilter);
            param.Add("@PageIndex", pageIndex);
            param.Add("@PageSize", pageSize);
            param.Add("@TotalRecord", direction: ParameterDirection.Output);
            param.Add("@TotalPage", direction: ParameterDirection.Output);

            List<Employee> employees = DbConnection.Query<Employee>(sqlCommandString, param, commandType: CommandType.StoredProcedure).ToList();

            Int64 totalPage = param.Get<Int64>("@TotalPage");
            Int64 totalRecord = param.Get<Int64>("@TotalRecord");

            return new
            {
                TotalPage = totalPage,
                TotalRecord = totalRecord,
                List = employees
            };
        }

        /// <summary>
        /// Xóa nhiều nhân viên
        /// </summary>
        /// <param name="employeeList"></param>
        /// <returns></returns>
        public int DeleteEmployees(List<Guid> employeeList) {
            DbConnection.Open();
            using (var transaction = DbConnection.BeginTransaction()) {
                try {
                    foreach (Guid id in employeeList) {
                        //khởi tạo các commandText
                        var parameterId = new DynamicParameters();
                        parameterId.Add($"@EmployeeId", id);
                        var rowAffects = DbConnection.Execute($"Proc_DeleteEmployeeById", parameterId, commandType: CommandType.StoredProcedure, transaction: transaction);
                    }
                    //hoàn thành
                    transaction.Commit();
                    // đóng kết nối
                    DbConnection.Close();
                    // trả về số dòng đã xóa
                    return employeeList.Count;
                }
                catch (Exception) {
                    // roll back lại transaction
                    transaction.Rollback();
                    // đóng kết nối
                    DbConnection.Close();
                    // trả về kết quả
                    return 0;
                }
            }
        }

        #endregion Methods
    }
}