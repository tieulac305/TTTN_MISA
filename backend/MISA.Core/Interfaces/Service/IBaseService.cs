using MISA.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace MISA.Core.Interfaces.Service
{
    public interface IBaseService<MISAEntity>
    {
        /// <summary>
        /// danh sách tất cả bản ghi
        /// </summary>
        /// <returns></returns>
        /// Author: CpNam 06.08.2021
        public ServiceResult GetAllEntities();

        /// <summary>
        /// lấy ra 1 bản ghi theo id
        /// </summary>
        /// <param name="entityId">mã định danh</param>
        /// Author: CpNam 06.08.2021
        public ServiceResult GetById(Guid entityId);

        /// <summary>
        /// xóa 1 bản ghi
        /// </summary>
        /// Author: CpNam 06.08.2021
        public ServiceResult DeleteById(Guid entityId);

        /// <summary>
        /// kiểm tra hợp lệ dữ liệu
        /// </summary>
        /// Author: CpNam 06.08.2021
        public bool IsValid(MISAEntity entity, ref ServiceResult serviceResult);

        /// <summary>
        /// thêm mới 1 bản ghi
        /// </summary>
        /// Author: CpNam 06.08.2021
        public ServiceResult AddEntity(MISAEntity entity);

        /// <summary>
        /// sửa 1 bản ghi với mã cho trước
        /// </summary>
        /// Author: CpNam 06.08.2021
        public ServiceResult EditEntity(Guid id, MISAEntity entity);

        /// <summary>
        /// thêm nhiều bản ghi
        /// </summary>
        /// <param name="entities"></param>
        /// <returns>số dòng bị ảnh hưởng</returns>
        public ServiceResult Import(List<MISAEntity> entities);
    }
}