using MISA.Core.Entities;
using MISA.Core.Enums;
using MISA.Core.Interfaces.Infrastructure;
using MISA.Core.Interfaces.Service;
using System;
using System.Collections.Generic;
using System.Text;

namespace MISA.Core.Services
{
    public class BaseService<MISAEntity> : IBaseService<MISAEntity>
    {
        #region Fields

        /// <summary>
        /// repo chung
        /// </summary>
        private IBaseRepository<MISAEntity> baseRepository;

        #endregion Fields

        #region Constructor

        /// <summary>
        /// khởi tạo service với repo chung
        /// </summary>
        /// Author: CpNam 17.08.2021
        public BaseService(IBaseRepository<MISAEntity> baseRepository) {
            this.baseRepository = baseRepository;
        }

        #endregion Constructor

        #region Methods

        /// <summary>
        /// danh sách tất cả bản ghi
        /// </summary>
        /// Author: CpNam 06.08.2021
        public ServiceResult GetAllEntities() {
            ServiceResult serviceResult = new ServiceResult();

            serviceResult.Data = baseRepository.GetAllEntities();
            serviceResult.MISACode = MISACode.Success;

            return serviceResult;
        }

        /// <summary>
        /// lấy ra 1 bản ghi theo id
        /// </summary>
        /// <param name="entityId">mã định danh</param>
        /// Author: CpNam 06.08.2021
        public ServiceResult GetById(Guid entityId) {
            ServiceResult serviceResult = new ServiceResult();

            serviceResult.MISACode = MISACode.Success;
            serviceResult.Data = baseRepository.GetById(entityId);

            if (serviceResult.Data == null) {
                serviceResult.MISACode = MISACode.Invalid;
                serviceResult.Messenger = Resources.Common.Response_NotFound;
            }

            return serviceResult;
        }

        /// <summary>
        /// xóa 1 bản ghi
        /// </summary>
        /// <param name="entityId">mã định danh</param>
        /// Author: CpNam 06.08.2021
        public ServiceResult DeleteById(Guid entityId) {
            ServiceResult serviceResult = new ServiceResult();

            int affectedRows = baseRepository.DeleteById(entityId);

            serviceResult.MISACode = MISACode.Success;
            serviceResult.Data = entityId;

            if (affectedRows == 0) {
                serviceResult.MISACode = MISACode.Invalid;
                serviceResult.Messenger = Resources.Common.Response_NotFound;
            }

            return serviceResult;
        }

        /// <summary>
        /// thêm mới 1 bản ghi
        /// </summary>
        /// Author: CpNam 06.08.2021
        public ServiceResult AddEntity(MISAEntity entity) {
            ServiceResult serviceResult = new ServiceResult();

            if (!IsValid(entity, ref serviceResult)) {
                return serviceResult;
            }

            baseRepository.AddEntity(entity);
            serviceResult.Data = entity;
            serviceResult.MISACode = MISACode.Success;

            return serviceResult;
        }

        /// <summary>
        /// sửa 1 bản ghi với mã cho trước
        /// </summary>
        /// Author: CpNam 06.08.2021
        public ServiceResult EditEntity(Guid id, MISAEntity entity) {
            // gán Id vào cho đối tượng (đối tượng gửi lên có thể không có id)
            string className = entity.GetType().Name;
            var propId = entity.GetType().GetProperty($"{className}Id");
            if (propId != null) {
                propId.SetValue(entity, id);
            }

            ServiceResult serviceResult = new ServiceResult();

            if (!IsValid(entity, ref serviceResult)) {
                return serviceResult;
            }

            int affectedRows = baseRepository.EditEntity(entity);
            serviceResult.Data = entity;
            if (affectedRows == 0) {
                serviceResult.MISACode = MISACode.Invalid;
                serviceResult.Messenger = Resources.Common.Response_NotFound;
            }
            else {
                serviceResult.MISACode = MISACode.Success;
            }

            return serviceResult;
        }

        /// <summary>
        /// kiểm tra hợp lệ dữ liệu
        /// </summary>
        /// Author: CpNam 06.08.2021
        public bool IsValid(MISAEntity entity, ref ServiceResult serviceResult) {
            var properties = entity.GetType().GetProperties();

            foreach (var property in properties) {
                var propertyValue = property.GetValue(entity);

                // kiểm tra required
                if (property.IsDefined(typeof(Required), false)) {
                    if (propertyValue == null || string.IsNullOrEmpty(propertyValue.ToString())) {
                        serviceResult.Data = property.Name;
                        serviceResult.MISACode = MISACode.Invalid;
                        serviceResult.Messenger = Resources.Common.ResponseError_RequiredError;

                        return false;
                    }
                }
                // kiểm tra độ dài
                if (property.IsDefined(typeof(MaxLength), false)) {
                    int maxLength = (property.GetCustomAttributes(typeof(MaxLength), false)[0] as MaxLength).Length;

                    if (propertyValue != null && propertyValue.ToString().Length > maxLength) {
                        serviceResult.Data = property.Name;
                        serviceResult.MISACode = MISACode.Invalid;
                        serviceResult.Messenger = Resources.Common.ResponseError_MaxLengthError;

                        return false;
                    }
                }
            }

            // kiểm tra riêng
            return ValidateCustom(entity, ref serviceResult);
        }

        /// <summary>
        /// validate riêng cho từng đối tượng
        /// </summary>
        protected virtual bool ValidateCustom(MISAEntity entity, ref ServiceResult serviceResult) {
            return true;
        }

        /// <summary>
        /// thêm nhiều bản ghi
        /// </summary>
        /// <param name="entities">danh sách đối tượng</param>
        /// <returns>data là dòng xuất hiện lỗi hoặc số dòng bị ảnh hưởng</returns>
        public ServiceResult Import(List<MISAEntity> entities) {
            ServiceResult serviceResult = new ServiceResult();

            int currentRow = 1;
            foreach (MISAEntity entity in entities) {
                if (!IsValid(entity, ref serviceResult)) {
                    serviceResult.Data = currentRow;
                    return serviceResult;
                }
                currentRow++;
            }

            serviceResult.Data = baseRepository.Import(entities);
            serviceResult.MISACode = MISACode.Success;

            return serviceResult;
        }

        #endregion Methods
    }
}