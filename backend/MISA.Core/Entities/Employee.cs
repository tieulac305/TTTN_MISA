using System;
using System.Collections.Generic;
using System.Text;

namespace MISA.Core.Entities
{
    /// <summary>
    /// nhân viên
    /// </summary>
    public class Employee : BaseEntity
    {
        /// <summary>
        /// Khóa chính
        /// </summary>
        public Guid EmployeeId { get; set; }

        /// <summary>
        /// Mã nhân viên
        /// </summary>
        [Required]
        [MaxLength(20)]
        public string EmployeeCode { get; set; }

        /// <summary>
        /// Họ và tên
        /// </summary>
        [Required]
        [MaxLength(100)]
        public string EmployeeName { get; set; }

        /// <summary>
        /// Ngày sinh
        /// </summary>
        public DateTime? DateOfBirth { get; set; }

        /// <summary>
        /// Giới tính
        /// </summary>
        public int? Gender { get; set; }

        /// <summary>
        /// Tên giới tính
        /// </summary>
        public string GenderName { get; set; }

        /// <summary>
        /// Mã phòng ban
        /// </summary>
        [Required]
        public Guid DepartmentId { get; set; }

        /// <summary>
        /// Tên phòng ban
        /// </summary>
        public string DepartmentName { get; set; }

        /// <summary>
        /// Số chứng minh nhân dân hoặc căn cước công dân
        /// </summary>
        [MaxLength(20)]
        public string IdentityNumber { get; set; }

        /// <summary>
        /// Ngày cấp CMND/CCCD
        /// </summary>
        public DateTime? IdentityDate { get; set; }

        /// <summary>
        /// Nơi cấp CMND/CCCD
        /// </summary>
        [MaxLength(255)]
        public string IdentityPlace { get; set; }

        /// <summary>
        /// Vị trí
        /// </summary>
        [MaxLength(255)]
        public string EmployeePosition { get; set; }

        /// <summary>
        /// Địa chỉ nhân viên
        /// </summary>
        [MaxLength(255)]
        public string Address { get; set; }

        /// <summary>
        /// Số tài khoản ngân hàng
        /// </summary>
        [MaxLength(20)]
        public string BankAccountNumber { get; set; }

        /// <summary>
        /// Tên ngân hàng
        /// </summary>
        [MaxLength(255)]
        public string BankName { get; set; }

        /// <summary>
        /// Chi nhánh ngân hàng
        /// </summary>
        [MaxLength(255)]
        public string BankBranchName { get; set; }

        /// <summary>
        /// Tên tỉnh
        /// </summary>
        [MaxLength(255)]
        public string BankProvinceName { get; set; }

        /// <summary>
        ///Số điện thoại
        /// </summary>
        [MaxLength(20)]
        public string PhoneNumber { get; set; }

        /// <summary>
        ///Số điện thoại cố định
        /// </summary>
        [MaxLength(20)]
        public string TelephoneNumber { get; set; }

        /// <summary>
        /// Địa chỉ email
        /// </summary>
        [MaxLength(50)]
        public string Email { get; set; }
    }
}