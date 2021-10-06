using Dapper;
using Microsoft.Extensions.Configuration;
using MISA.Core.Entities;
using MISA.Core.Interfaces.Infrastructure;
using MySqlConnector;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace MISA.Infrastructure.Repository
{
    public class BaseRepository<MISAEntity> : IBaseRepository<MISAEntity> where MISAEntity : BaseEntity
    {
        #region Fields

        /// <summary>
        /// chuỗi kết nối
        /// </summary>
        public string ConnectionString;

        /// <summary>
        /// kết nối
        /// </summary>
        protected IDbConnection DbConnection;

        /// <summary>
        /// tên class trong c# - tên bảng trong database
        /// </summary>
        private string className;

        /// <summary>
        /// configuration do microsoft cung cấp
        /// </summary>
        private IConfiguration configuration;

        #endregion Fields

        #region Constructors

        /// <summary>
        /// khởi tạo
        /// </summary>
        /// Author: CpNam 17.08.2021
        public BaseRepository(IConfiguration _configuration) {
            configuration = _configuration;
            ConnectionString = configuration.GetConnectionString("DefaultConnection");
            DbConnection = new MySqlConnection(ConnectionString);
            className = typeof(MISAEntity).Name;
        }

        #endregion Constructors

        #region Methods

        /// <summary>
        /// Lấy tất cả dữ liệu từ một bảng
        /// </summary>
        /// <returns>dữ liệu</returns>
        /// Author: CpNam 28.07.2021
        public List<MISAEntity> GetAllEntities() {
            string sqlCommandString = $"Proc_Get{className}s";

            return DbConnection.Query<MISAEntity>(sqlCommandString, commandType: CommandType.StoredProcedure).ToList();
        }

        /// <summary>
        /// lấy thông tin một đối tượng theo khóa chính
        /// </summary>
        /// <param name="entityId">mã định danh</param>
        /// <returns></returns>
        /// Author: CpNam 20.07.2021
        public MISAEntity GetById(Guid entityId) {
            string sqlCommandString = $"Proc_Get{className}ById";

            DynamicParameters param = new DynamicParameters();
            param.Add($"@{className}Id", entityId);

            return DbConnection.QueryFirstOrDefault<MISAEntity>(sqlCommandString, param, commandType: CommandType.StoredProcedure);
        }

        /// <summary>
        /// lấy thông tin một đối tượng theo mã
        /// </summary>
        /// <param name="code">mã</param>
        /// Author: CpNam 05.08.2021
        public MISAEntity GetByCode(string entityCode) {
            string sqlCommandString = $"Proc_Get{className}ByCode";

            DynamicParameters param = new DynamicParameters();
            param.Add($"@{className}Code", entityCode);

            return DbConnection.QueryFirstOrDefault<MISAEntity>(sqlCommandString, param, commandType: CommandType.StoredProcedure);
        }

        /// <summary>
        /// xóa đối tượng theo id
        /// </summary>
        /// <param name="entityId">mã định danh</param>
        /// <returns>số dòng bị ảnh hưởng</returns>
        /// Author: CpNam 05.08.2021
        public int DeleteById(Guid entityId) {
            string sqlCommandString = $"Proc_Delete{className}ById";

            DynamicParameters param = new DynamicParameters();
            param.Add($"@{className}Id", entityId);

            return DbConnection.Execute(sqlCommandString, param, commandType: CommandType.StoredProcedure);
        }

        /// <summary>
        /// thêm mới một đối tượng
        /// </summary>
        /// <param name="entity">đối tượng</param>
        /// <returns>số dòng bị ảnh hưởng</returns>
        /// Author: CpNam 05.08.2021
        public int AddEntity(MISAEntity entity) {
            string sqlCommandString = $"Proc_Insert{className}";

            DynamicParameters param = new DynamicParameters();
            param.AddDynamicParams(entity);

            return DbConnection.Execute(sqlCommandString, param, commandType: CommandType.StoredProcedure);
        }

        /// <summary>
        /// sửa một đối tượng
        /// </summary>
        /// <param name="entity">đối tượng</param>
        /// <returns>số dòng bị ảnh hưởng</returns>
        /// Author: CpNam 05.08.2021
        public int EditEntity(MISAEntity entity) {
            string sqlCommandString = $"Proc_Update{className}";

            DynamicParameters param = new DynamicParameters();
            param.AddDynamicParams(entity);

            return DbConnection.Execute(sqlCommandString, param, commandType: CommandType.StoredProcedure);
        }

        public int Import(List<MISAEntity> entities) {
            DbConnection.Open();
            using (var transaction = DbConnection.BeginTransaction()) {
                try {
                    int rowsAffected = 0;
                    foreach (MISAEntity entity in entities) {
                        string sqlCommandString = $"Proc_Insert{className}";

                        DynamicParameters param = new DynamicParameters();
                        param.AddDynamicParams(entity);

                        rowsAffected += DbConnection.Execute(sqlCommandString, param, commandType: CommandType.StoredProcedure, transaction: transaction);
                    }
                    //hoàn thành
                    transaction.Commit();
                    // đóng kết nối
                    DbConnection.Close();
                    // trả về số dòng bị ảnh hưởng
                    return rowsAffected;
                }
                catch (Exception) {
                    // roll back lại transaction
                    transaction.Rollback();
                    // đóng kết nối
                    DbConnection.Close();
                    // trả về kết quả
                    throw;
                }
            }
        }

        #endregion Methods
    }
}