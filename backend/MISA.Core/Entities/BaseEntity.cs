using System;
using System.Collections.Generic;
using System.Text;

namespace MISA.Core.Entities
{
    /// <summary>
    /// Kiểm tra các bản ghi cần required
    /// </summary>
    [AttributeUsage(AttributeTargets.Property)]
    public class Required : Attribute
    {
    }

    /// <summary>
    /// Kiểm tra kích thước dữ liệu
    /// </summary>
    [AttributeUsage(AttributeTargets.Property)]
    public class MaxLength : Attribute
    {
        public int Length { get; set; }

        public MaxLength(int length) {
            Length = length;
        }
    }

    /// <summary>
    /// các thuộc tính chung của các class
    /// </summary>
    public class BaseEntity
    {
        /// <summary>
        /// Ngày tạo
        /// </summary>
        public DateTime CreatedDate { get; set; }

        /// <summary>
        /// Tạo bởi
        /// </summary>
        [MaxLength(100)]
        public string CreatedBy { get; set; }

        /// <summary>
        /// Ngày thay đổi
        /// </summary>
        public DateTime? ModifiedDate { get; set; }

        /// <summary>
        /// Thay đổi bởi
        /// </summary>
        [MaxLength(100)]
        public string ModifiedBy { get; set; }
    }
}