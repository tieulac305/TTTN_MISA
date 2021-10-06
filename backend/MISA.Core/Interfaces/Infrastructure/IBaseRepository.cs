using System;
using System.Collections.Generic;
using System.Text;

namespace MISA.Core.Interfaces.Infrastructure
{
    public interface IBaseRepository<MISAEntity>
    {
        /// <summary>
        /// danh sách tất cả bản ghi
        /// </summary>
        /// Author: CpNam 05.08.2021
        public List<MISAEntity> GetAllEntities();

        /// <summary>
        /// lấy ra 1 bản ghi theo id
        /// </summary>
        /// <param name="entityId">mã định danh</param>
        /// Author: CpNam 05.08.2021
        public MISAEntity GetById(Guid entityId);

        /// <summary>
        /// lấy ra 1 bản ghi theo mã
        /// </summary>
        /// <param name="entityCode">mã</param>
        /// Author: CpNam 05.08.2021
        public MISAEntity GetByCode(string entityCode);

        /// <summary>
        /// xóa 1 bản ghi
        /// </summary>
        /// <param name="entityId">mã định danh</param>
        /// <returns>số dòng bị ảnh hưởng</returns>
        /// Author: CpNam 05.08.2021
        public int DeleteById(Guid entityId);

        /// <summary>
        /// thêm mới 1 bản ghi
        /// </summary>
        /// <param name="entity"></param>
        /// <returns>số dòng bị ảnh hưởng</returns>
        /// Author: CpNam 05.08.2021
        public int AddEntity(MISAEntity entity);

        /// <summary>
        /// sửa 1 bản ghi với mã cho trước
        /// </summary>
        /// <param name="entity"></param>
        /// <returns>số dòng bị ảnh hưởng</returns>
        /// Author: CpNam 05.08.2021
        public int EditEntity(MISAEntity entity);

        /// <summary>
        /// thêm nhiều bản ghi
        /// </summary>
        /// <param name="entities"></param>
        /// <returns>số dòng bị ảnh hưởng</returns>
        public int Import(List<MISAEntity> entities);
    }
}