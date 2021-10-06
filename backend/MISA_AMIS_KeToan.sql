-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

SET NAMES 'utf8';

DROP DATABASE IF EXISTS `WEB06.TEST.MF865.CPNAM`;

CREATE DATABASE `WEB06.TEST.MF865.CPNAM`
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE `WEB06.TEST.MF865.CPNAM`;

--
-- Create table `Department`
--
CREATE TABLE Department (
  DepartmentId char(36) NOT NULL COMMENT 'Mã định danh',
--   DepartmentCode varchar(20) NOT NULL DEFAULT '' COMMENT 'Mã phòng ban',
  DepartmentName varchar(255) NOT NULL DEFAULT '' COMMENT 'Tên phòng ban',
  Description varchar(255) DEFAULT NULL COMMENT 'Mô tả',
  CreatedBy varchar(100) DEFAULT NULL COMMENT 'Người tạo',
  CreatedDate datetime DEFAULT NULL COMMENT 'Ngày tạo',
  ModifiedBy varchar(100) DEFAULT NULL COMMENT 'Người sửa',
  ModifiedDate datetime DEFAULT NULL COMMENT 'Ngày sửa',
  PRIMARY KEY (DepartmentId)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci,
COMMENT = 'Phòng ban';

--
-- Create procedure `Proc_GetDepartments`
--
CREATE PROCEDURE Proc_GetDepartments ()
  COMMENT 'Lấy toàn bộ danh sách phòng ban'
BEGIN
  SELECT
    *
  FROM Department d;
END;

--
-- Create procedure `Proc_GetDepartmentById`
--
CREATE PROCEDURE Proc_GetDepartmentById (IN DepartmentId char(36))
  COMMENT 'Lấy đơn vị/phòng ban theo mã định danh'
BEGIN
  SELECT
    *
  FROM Department d
  WHERE d.DepartmentId = DepartmentId;
END;

--
-- Create table `Employee`
--
CREATE TABLE Employee (
  EmployeeId char(36) NOT NULL COMMENT 'Mã định danh',
  EmployeeCode varchar(20) NOT NULL COMMENT 'Mã nhân viên',
  EmployeeName varchar(100) NOT NULL COMMENT 'Tên nhân viên',
  DateOfBirth date DEFAULT NULL COMMENT 'Ngày sinh',
  Gender int(11) DEFAULT NULL COMMENT 'Giới tính: 0-nam; 1-nữ; 2-khác',
  DepartmentId char(36) NOT NULL COMMENT 'ID phòng ban',
  IdentityNumber varchar(20) DEFAULT NULL COMMENT 'Số chứng minh thư nhân dân/ căn cước công dân',
  IdentityDate date DEFAULT NULL COMMENT 'Ngày cấp CMND/CCCD',
  IdentityPlace varchar(255) DEFAULT NULL COMMENT 'Nơi cấp CMND/CCCD',
  EmployeePosition varchar(255) DEFAULT NULL COMMENT 'Vị trí',
  Address varchar(255) DEFAULT NULL COMMENT 'Địa chỉ',
  BankAccountNumber varchar(20) DEFAULT NULL COMMENT 'Số tài khoản ngân hàng',
  BankName varchar(255) DEFAULT NULL COMMENT 'Tên ngân hàng',
  BankBranchName varchar(255) DEFAULT NULL COMMENT 'Tên chi nhánh ngân hàng',
  BankProvinceName varchar(255) DEFAULT NULL COMMENT 'Tên tỉnh',
  PhoneNumber varchar(20) DEFAULT NULL COMMENT 'Số điện thoại di động',
  TelephoneNumber varchar(20) DEFAULT NULL COMMENT 'Số điện thoại cố định',
  Email varchar(50) DEFAULT NULL COMMENT 'Email nhân viên',
  CreatedBy varchar(100) DEFAULT NULL COMMENT 'Người tạo',
  CreatedDate datetime DEFAULT NULL COMMENT 'Ngày tạo',
  ModifiedBy varchar(100) DEFAULT NULL COMMENT 'Người sửa',
  ModifiedDate datetime DEFAULT NULL COMMENT 'Ngày sửa',
  PRIMARY KEY (EmployeeId)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci,
COMMENT = 'Nhân viên';

--
-- Create index `UK_Employee_EmployeeCode` on table `Employee`
--
ALTER TABLE Employee
ADD UNIQUE INDEX UK_Employee_EmployeeCode (EmployeeCode);

--
-- Create foreign key
--
ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_DepartmentId FOREIGN KEY (DepartmentId)
REFERENCES Department (DepartmentId) ON DELETE NO ACTION;

--
-- Create procedure `Proc_GetEmployeeByCode`
--
CREATE PROCEDURE Proc_GetEmployeeByCode (IN EmployeeCode varchar(20))
  COMMENT 'Lấy nhân viên theo mã nhân viên'
BEGIN
  SELECT
    *
  FROM Employee e
  WHERE e.EmployeeCode = EmployeeCode LIMIT 1;
END;

--
-- Create procedure `Proc_UpdateEmployee`
--
CREATE PROCEDURE Proc_UpdateEmployee (
  IN Address varchar(255),
  IN BankAccountNumber varchar(20),
  IN BankBranchName varchar(255),
  IN BankName varchar(255),
  IN BankProvinceName varchar(255),
  IN CreatedBy varchar(100),
  IN CreatedDate date,
  IN DateOfBirth date,
  IN DepartmentId char(36),
  IN DepartmentName varchar(255),
  IN Email varchar(255),
  IN EmployeeCode varchar(20),
  IN EmployeeId char(36),
  IN EmployeeName varchar(100),
  IN EmployeePosition varchar(100),
  IN Gender int,
  IN GenderName varchar(255),
  IN IdentityDate date,
  IN IdentityNumber varchar(50),
  IN IdentityPlace varchar(255),
  IN ModifiedBy varchar(20),
  IN ModifiedDate date,
  IN PhoneNumber varchar(50),
  IN TelephoneNumber varchar(50)
  )
    COMMENT 'Cập nhật nhân viên'
BEGIN
  UPDATE Employee e
  SET e.EmployeeCode = EmployeeCode,
      e.EmployeeName = EmployeeName,
      e.DateOfBirth = DateOfBirth,
      e.Gender = Gender,
      e.DepartmentId = DepartmentId,
      e.IdentityNumber = IdentityNumber,
      e.IdentityDate = IdentityDate,
      e.IdentityPlace = IdentityPlace,
      e.EmployeePosition = EmployeePosition,
      e.Address = Address,
      e.BankAccountNumber = BankAccountNumber,
      e.BankName = BankName,
      e.BankBranchName = BankBranchName,
      e.BankProvinceName = BankProvinceName,
      e.PhoneNumber = PhoneNumber,
      e.TelephoneNumber = TelephoneNumber,
      e.Email = Email,
      e.ModifiedBy = ModifiedBy,
      e.ModifiedDate = NOW()
  WHERE e.EmployeeId = EmployeeId;
END;

--
-- Create procedure `Proc_InsertEmployee`
--
CREATE PROCEDURE Proc_InsertEmployee (
  IN Address varchar(255),
  IN BankAccountNumber varchar(20),
  IN BankBranchName varchar(255),
  IN BankName varchar(255),
  IN BankProvinceName varchar(255),
  IN CreatedBy varchar(100),
  IN CreatedDate date,
  IN DateOfBirth date,
  IN DepartmentId char(36),
  IN DepartmentName varchar(255),
  IN Email varchar(255),
  IN EmployeeCode varchar(20),
  IN EmployeeId char(36),
  IN EmployeeName varchar(100),
  IN EmployeePosition varchar(100),
  IN Gender int,
  IN GenderName varchar(255),
  IN IdentityDate date,
  IN IdentityNumber varchar(50),
  IN IdentityPlace varchar(255),
  IN ModifiedBy varchar(20),
  IN ModifiedDate date,
  IN PhoneNumber varchar(50),
  IN TelephoneNumber varchar(50)
  )
    COMMENT 'Thêm nhân viên'
BEGIN
  INSERT INTO Employee (EmployeeId,
  EmployeeCode,
  EmployeeName,
  DateOfBirth,
  Gender,
  DepartmentId,
  IdentityNumber,
  IdentityDate,
  IdentityPlace,
  EmployeePosition,
  Address,
  BankAccountNumber,
  BankName,
  BankBranchName,
  BankProvinceName,
  PhoneNumber,
  TelephoneNumber,
  Email,
  CreatedBy,
  CreatedDate)
    VALUES (UUID(), EmployeeCode, EmployeeName, DateOfBirth, Gender, DepartmentId, IdentityNumber, IdentityDate, IdentityPlace, EmployeePosition, Address, BankAccountNumber, BankName, BankBranchName, BankProvinceName, PhoneNumber, TelephoneNumber, Email, CreatedBy, NOW());
END;

--
-- Create function `Func_GetSubfixIsNumber`
--
CREATE FUNCTION Func_GetSubfixIsNumber (InputString varchar(255))
RETURNS int(11)
  COMMENT 'Lấy ra đuôi mã là một số'
BEGIN
  DECLARE ctrNumber varchar(50);
  DECLARE finNumber varchar(50) DEFAULT '';
  DECLARE sChar varchar(1);
  DECLARE inti integer DEFAULT 1;
  SET inti = LENGTH(InputString);

  IF LENGTH(InputString) > 0 THEN
    WHILE (inti > 0) DO
      SET sChar = SUBSTRING(InputString, inti, 1);
      SET ctrNumber = FIND_IN_SET(sChar, '1,2,3,4,5,6,7,8,9');
      IF ctrNumber > 0 THEN
        SET finNumber = CONCAT(finNumber, sChar);
      ELSE
        RETURN CAST(finNumber AS UNSIGNED);
      END IF;
      SET inti = inti - 1;
    END WHILE;
    RETURN CAST(finNumber AS UNSIGNED);
  ELSE
    RETURN 0;
  END IF;
END;

--
-- Create procedure `Proc_GetNewEmployeeCode`
--
CREATE PROCEDURE Proc_GetNewEmployeeCode ()
  COMMENT 'Lấy ra mã nhân viên mới'
BEGIN
  SET @LASTEST_CODE = (SELECT
      e.EmployeeCode
    FROM Employee e
    ORDER BY e.CreatedDate DESC LIMIT 1);
  SET @SUB_LASTEST_CODE = (SELECT
      Func_GetSubfixIsNumber(@LASTEST_CODE));
  SET @SUB_NEW_CODE = @SUB_LASTEST_CODE + 1;
  SET @LASTEST_CODE_LEN = LENGTH(@LASTEST_CODE);
  SET @SUB_LASTEST_CODE_LEN = LENGTH(@SUB_LASTEST_CODE);
  SET @PREFIX_CODE = LEFT(@LASTEST_CODE, @LASTEST_CODE_LEN - @SUB_LASTEST_CODE_LEN);

  SET @NEW_CODE = CONCAT(@PREFIX_CODE, @SUB_NEW_CODE);
  SELECT
    @NEW_CODE;
END;

--
-- Create procedure `Proc_GetEmployees`
--
CREATE PROCEDURE Proc_GetEmployees ()
  COMMENT 'Lấy toàn bộ danh sách nhân viên'
BEGIN
  SELECT
    `e`.`EmployeeId` AS `EmployeeId`,
    `e`.`EmployeeCode` AS `EmployeeCode`,
    `e`.`EmployeeName` AS `EmployeeName`,
    `e`.`Gender` AS `Gender`,
    Func_RetreiveGenderName(`e`.`Gender`) AS `GenderName`,
    `e`.`DateOfBirth` AS `DateOfBirth`,
    `e`.`PhoneNumber` AS `PhoneNumber`,
    `e`.`TelephoneNumber` AS `TelephoneNumber`,
    `e`.`Email` AS `Email`,
    `e`.`Address` AS `Address`,
    `e`.`EmployeePosition` AS `EmployeePosition`,
    `e`.`BankAccountNumber` AS `BankAccountNumber`,
    `e`.`BankName` AS `BankName`,
    `e`.`BankBranchName` AS `BankBranchName`,
    `e`.`BankProvinceName` AS `BankProvinceName`,
    `e`.`IdentityNumber` AS `IdentityNumber`,
    `e`.`IdentityDate` AS `IdentityDate`,
    `e`.`IdentityPlace` AS `IdentityPlace`,
    `d`.`DepartmentId` AS `DepartmentId`,
    `d`.`DepartmentName` AS `DepartmentName`,
    `e`.`CreatedDate` AS `CreatedDate`,
    `e`.`CreatedBy` AS `CreatedBy`,
    `e`.`ModifiedDate` AS `ModifiedDate`,
    `e`.`ModifiedBy` AS `ModifiedBy`
  FROM `Employee` `e`
    LEFT JOIN `Department` `d`
      ON `e`.`DepartmentId` = `d`.`DepartmentId`
  ORDER BY e.CreatedDate DESC;
END;

--
-- Lấy gendername
--
CREATE FUNCTION Func_RetreiveGenderName(Gender INT)
  RETURNS VARCHAR(255) CHARSET utf8mb4
  COMMENT 'Hàm lấy ra tên giới tính tương ứng với enum'
BEGIN
  IF Gender = 1 THEN RETURN 'Nam';
  ELSEIF Gender = 0 THEN RETURN 'Nữ';
  ELSEIF Gender = 2 THEN RETURN 'Khác';
  ELSE RETURN '';
  END IF;
END;

--
-- Create procedure `Proc_GetEmployeesFilterPaging`
--
CREATE PROCEDURE Proc_GetEmployeesFilterPaging (IN EmployeeFilter varchar(255), IN PageIndex int, IN PageSize int, OUT TotalRecord int, OUT TotalPage int)
  COMMENT 'Lấy nhân viên từ bộ lọc theo trang'
BEGIN
  DECLARE PageOffset int;
  SET @EmployeeFilter = (SELECT EmployeeFilter);
  SET PageOffset = (PageIndex-1)*PageSize;
 IF PageSize > 0 THEN
      CREATE TEMPORARY TABLE FilteredTable
        SELECT
          `e`.`EmployeeId` AS `EmployeeId`,
          `e`.`EmployeeCode` AS `EmployeeCode`,
          `e`.`EmployeeName` AS `EmployeeName`,
          `e`.`Gender` AS `Gender`,
          Func_RetreiveGenderName(`e`.`Gender`) AS `GenderName`,
          `e`.`DateOfBirth` AS `DateOfBirth`,
          `e`.`PhoneNumber` AS `PhoneNumber`,
          `e`.`TelephoneNumber` AS `TelephoneNumber`,
          `e`.`Email` AS `Email`,
          `e`.`Address` AS `Address`,
          `e`.`EmployeePosition` AS `EmployeePosition`,
          `e`.`BankAccountNumber` AS `BankAccountNumber`,
          `e`.`BankName` AS `BankName`,
          `e`.`BankBranchName` AS `BankBranchName`,
          `e`.`BankProvinceName` AS `BankProvinceName`,
          `e`.`IdentityNumber` AS `IdentityNumber`,
          `e`.`IdentityDate` AS `IdentityDate`,
          `e`.`IdentityPlace` AS `IdentityPlace`,
          `d`.`DepartmentId` AS `DepartmentId`,
          `d`.`DepartmentName` AS `DepartmentName`,
          `e`.`CreatedDate` AS `CreatedDate`,
          `e`.`CreatedBy` AS `CreatedBy`,
          `e`.`ModifiedDate` AS `ModifiedDate`,
          `e`.`ModifiedBy` AS `ModifiedBy`
        FROM ((`Employee` `e`
          LEFT JOIN `Department` `d`
            ON ((`e`.`DepartmentId` = `d`.`DepartmentId`))))
        WHERE @EmployeeFilter IS NULL 
        OR e.EmployeeCode LIKE CONCAT('%', @EmployeeFilter, '%')
        OR e.`EmployeeName` LIKE CONCAT('%', @EmployeeFilter, '%')
        OR e.PhoneNumber LIKE CONCAT('%', @EmployeeFilter, '%')
        ORDER BY e.CreatedDate DESC;
      
      -- chạy rất là chậm luôn nếu mà offset lớn
      SELECT * FROM FilteredTable ft LIMIT PageSize OFFSET PageOffSet;

      SET TotalRecord = (SELECT
          COUNT(*)
        FROM FilteredTable ft);

      DROP TEMPORARY TABLE FilteredTable;

      SET @NumberRecordLastPage = TotalRecord % PageSize;
      IF @NumberRecordLastPage > 0 THEN
        SET TotalPage = FLOOR(TotalRecord / PageSize) + 1;
      ELSE
        SET TotalPage = TotalRecord / PageSize;
      END IF;
    END IF;
END;

--
-- Create procedure `Proc_GetEmployeeById`
--
CREATE PROCEDURE Proc_GetEmployeeById (IN EmployeeId char(36))
  COMMENT 'Lấy nhân viên theo mã định danh'
BEGIN
  SELECT
    *
  FROM Employee e
  WHERE e.EmployeeId = EmployeeId;
END;

--
-- Create procedure `Proc_DeleteEmployeeById`
--
CREATE PROCEDURE Proc_DeleteEmployeeById (IN EmployeeId char(36))
  COMMENT 'Xóa nhân viên theo mã định danh'
BEGIN
  DELETE
    FROM Employee
  WHERE Employee.EmployeeId = EmployeeId;
END;

--
-- Create procedure `Proc_CheckEmployeeCodeExist`
--
CREATE PROCEDURE Proc_CheckEmployeeCodeExist (IN EmployeeCode varchar(20))
  COMMENT 'Kiểm tra tồn tại mã nhân viên'
BEGIN
  SELECT
    EXISTS (SELECT
        *
      FROM Employee e
      WHERE e.EmployeeCode = EmployeeCode);
END;

-- 
-- Dumping data for table Department
--
INSERT INTO Department VALUES
('11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', 'Phòng nhân sự', 'Quo et consectetur. Omnis dolorem delectus quo corporis suscipit officiis; incidunt saepe vel nostrum ex et sed.', 'minh misa', '2015-11-23 10:39:07', 'tuan hoan', '1982-12-27 05:49:13'),
('142cb08f-7c31-21fa-8e90-67245e8b283e', 'Phòng Marketing', 'Praesentium excepturi architecto ipsum possimus. Dolore molestiae omnis nihil. Aliquid perspiciatis qui. Ea sed nam; accusantium ipsam ut. Soluta.', 'nguyen misa', '1970-01-01 00:07:13', 'minh hoan', '1970-01-01 00:00:04'),
('17120d02-6ab5-3e43-18cb-66948daf6128', 'Phòng kế toán', 'Neque amet ut. Natus quis ratione. Itaque tempore ut. Enim impedit magnam. Quo consectetur temporibus! Excepturi debitis perspiciatis. Quis et expedita!', 'tuan abc', '1998-06-04 20:45:17', 'minh cuon', '1990-04-09 09:18:44'),
('469b3ece-744a-45d5-957d-e8c757976496', 'Phòng nghiên cứu', 'Quam odit provident dolor. Natus error velit consequatur hic vero ut! Est nemo molestiae adipisci qui quia ipsam.', 'nguyen hoan', '2002-09-26 03:41:23', 'pro prir', '2002-03-01 10:01:41'),
('4e272fc4-7875-78d6-7d32-6a1673ffca7c', 'Phòng đào tạo', 'Qui tempora nisi similique laboriosam illum nesciunt. Unde similique omnis voluptatem sit nisi ipsum. Illum accusantium sit quia quidem; in et fuga.', 'tran misa', '1971-05-09 19:10:13', 'tran misa', '1970-01-01 00:00:08');

-- 
-- Dumping data for table Employee
--
INSERT INTO Employee VALUES
('11a8748f-3464-740c-28c2-579daad24557', 'NV-3265', 'Tạ An Thu', '1960-12-10 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '69472990', '1970-01-01 01:00:32', 'Nghệ An ', 'Thực tập sinh', 'Lâm Đồng', '28810', 'Ngân hàng Nam Á', 'Phú Yên', 'Bà Rịa – Vũng Tàu', '0593696284', '0822558963', 'Abbie.Sample@misa.com', 'Thị Hạnh', '1970-01-01 02:05:18', 'Ngọc Huyền', '1970-01-01 00:00:03'),
('1208b54a-66ee-355a-46c2-579daad24557', 'NV-6330', 'Sái An Thảo', '1951-02-04 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '73091260', '1970-01-01 00:00:35', 'An Giang  ', 'Phó phòng', 'Lai Châu', '27112', 'Ngân hàng Á Châu', 'Đồng Nai ', 'Bắc Kạn', '0373452214', '0956797765', 'Eddie_Parkinson892@misa.com', 'Thị Nga', '1971-07-20 01:37:28', 'Văn Luân', '1970-01-01 00:00:10'),
('1219e510-59ef-36fc-45c2-579daad24557', 'NV-3212', 'Lý Ngọc Hạnh', '1972-12-22 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '64851246', '1970-01-01 02:13:47', 'Bắc Giang ', 'Giám đốc', 'Bà Rịa – Vũng Tàu', '37036', 'Ngân hàng Quân đội', 'Lạng Sơn', 'Kon Tum', '0364705045', '0367873037', 'uapmbepn_phymy@misa.com', 'Anh Hằng', '2007-07-09 18:19:30', 'Mộc Hương', '2019-10-18 21:03:25'),
('12693b29-274c-35ce-d11d-086412a8ea97', 'NV-0555', 'Đặng Thị Phương', '1959-08-17 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '82885767', '1989-09-13 11:03:45', 'Đồng Tháp  ', 'Nhân viên', 'Nghệ An', '84373', 'Ngân hàng PVcombank', 'Quảng Nam', 'Kon Tum', '0583678554', '0778211845', 'Lefebvre@gmail.com', 'Khánh Nga', '2017-01-29 08:36:35', 'Khánh Giang', '1970-01-01 00:01:38'),
('12e12a5c-6e3a-503a-d71d-086412a8ea97', 'NV-6059', 'Lê Văn Luân', '1996-11-29 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '59467376', '2014-11-15 17:13:13', 'Bắc Giang ', 'Trưởng phòng', 'Bắc Ninh ', '10438', 'Ngân hàng Đông Nam Á', 'Ninh Thuận', 'Bạc Liêu ', '0580340505', '0544886412', 'PamulaD.Sena@gmail.com', 'Thị Nhung', '1977-08-21 14:02:33', 'Ngọc Yến', '1970-12-20 23:09:15'),
('12e1b096-3542-127a-1077-d9ebc53aac3d', 'NV-7129', 'Quàng An Toản', '1957-01-06 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '85679619', '1998-06-24 16:44:09', 'Bắc Kạn ', 'Giám đốc', 'Phú Thọ', '46213', 'Ngân hàng Hàng Hải Việt Nam', 'Bình Định ', 'Bạc Liêu ', '0548167681', '0856720777', 'Guest76@gmail.com', 'Thị Yến', '1980-08-05 04:11:58', 'Duy Trung', '1970-01-01 00:00:05'),
('13241f9b-34c5-6720-9641-c1ec321fe728', 'NV-7888', 'Huỳnh Ngọc Anh', '1990-08-10 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '04262801', '1987-11-18 02:39:20', 'Nam Định ', 'Nhân viên', 'Lâm Đồng', '35679', 'Ngân hàng Bắc Á', 'Nghệ An', 'Phú Yên', '0752022942', '0528828216', 'KenyettaAbel72@gmail.com', 'Văn Cường', '1986-04-05 11:31:32', 'Duy Hiệp', '2020-04-03 23:22:08'),
('134608bd-48c2-5fd7-1435-60b3ebf808a9', 'NV-9123', 'Lưu Anh Nhung', '1976-07-15 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '85565977', '1995-09-13 09:00:25', 'Sơn La ', 'Nhân viên cấp cao', 'Đắk Lắk ', '04275', 'Ngân hàng An Bình', 'Bến Tre ', 'Đồng Nai ', '0804722932', '0771258900', 'jaghuh7@gmail.com', 'Văn Hiệp', '2002-09-19 20:56:33', 'Khánh Sơn', '1970-01-01 00:00:07'),
('13e1d857-71ca-355c-5835-0028ed526dd0', 'NV-0425', 'Lý Văn Minh', '1983-05-12 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '07943910', '2016-05-15 19:53:46', 'Bạc Liêu  ', 'Thực tập sinh', 'Bắc Giang', '98690', 'Ngân hàng Bắc Á', 'Nam Định', 'Phú Thọ', '0307190161', '0895334210', 'Tyree_Noonan@gmail.com', 'Khánh Nhung', '2006-01-22 03:56:24', 'Văn Toản', '1987-08-05 10:50:28'),
('13ede5b6-19dd-563e-1980-de64d090a2c2', 'NV-7730', 'Phạm Thị Hoa', '1989-07-07 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '06604632', '2001-06-23 19:03:22', 'Bà Rịa – Vũng Tàu ', 'Phó phòng', 'An Giang ', '63877', 'Ngân hàng Phương Đông', 'Lâm Đồng', 'Quảng Bình', '0725174045', '0308979666', 'wnyfeyzw_nniur@gmail.com', 'Thị Hà', '2009-09-15 04:51:57', 'Khánh Thảo', '1970-01-01 00:12:43'),
('143e4110-751a-5474-1f80-de64d090a2c2', 'NV-0497', 'Tán Duy Toản', '1967-07-07 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '70836006', '1970-01-01 01:40:32', 'Phú Yên ', 'Nhân viên', 'Bình Định ', '39992', 'Ngân hàng Kỹ Thương Việt Nam', 'Điện Biên ', 'Nghệ An', '0779014472', '0786302654', 'NamBrito@misa.com', 'Khánh Ngọc', '1977-06-21 20:48:56', 'Thị Thảo', '1998-07-19 07:59:56'),
('14aa1334-3d35-32c4-30c2-579daad24557', 'NV-0526', 'Võ Văn Sơn', '1953-12-23 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '75873239', '1988-07-25 04:10:47', 'Bắc Kạn ', 'Nhân viên cấp cao', 'Cà Mau ', '50237', 'Ngân hàng Bản Việt', 'Ninh Thuận', 'Nam Định', '0903872685', '0587159172', 'rkhczgjz_shjphkcv@misa.com', 'Thị Thảo', '1978-09-28 05:57:20', 'Văn Linh', '1972-08-14 02:38:19'),
('1518ced5-6993-37f8-6180-7ed9d1ea06ea', 'NV-6941', 'Phan Khánh Mai', '1995-06-25 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '21857076', '1977-01-18 17:33:18', 'An Giang  ', 'Nhân viên cấp cao', 'Sóc Trăng', '46559', 'Ngân hàng Quân đội', 'Bắc Ninh ', 'Quảng Bình', '0884602848', '0790151541', 'Hilton_Boucher@gmail.com', 'Văn ', '1997-08-06 08:27:23', 'Anh Tuấn', '1970-01-01 00:00:08'),
('156bb711-53c6-12ee-5d80-7ed9d1ea06ea', 'NV-7268', 'Hoàng Khánh Hằng', '1964-05-17 00:00:00', 1, '142cb08f-7c31-21fa-8e90-67245e8b283e', '25390097', '2002-07-15 04:27:01', 'Quảng Nam ', 'Quản lý', 'Bắc Ninh ', '14104', 'Ngân hàng Hàng Hải Việt Nam', 'Quảng Ninh', 'Quảng Bình', '0822320244', '0817289500', 'Berry_Mccain@gmail.com', 'Văn Quang', '1995-02-09 00:44:56', NULL, '1970-01-01 00:00:14'),
('15acfdfd-12d7-52f6-2777-d9ebc53aac3d', 'NV-7340', 'Quàng Thị Nhung', '1951-03-17 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '42702384', '1970-01-01 00:01:16', 'Cần Thơ  ', 'Giám đốc', 'Quảng Ngãi', '10471', 'Ngân hàng Á Châu', 'Lâm Đồng', 'Sóc Trăng', '0937643382', '0916270944', 'Earl_GHarden@misa.com', 'Văn Toản', '2010-10-20 05:02:53', NULL, '1970-01-01 00:00:08'),
('15f7fc94-6dce-3bce-2680-de64d090a2c2', 'NV-1868', 'Vũ An Huy', '1953-01-22 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '76669719', '1970-01-01 00:12:33', 'Bạc Liêu  ', 'Nhân viên cấp cao', 'Bình Phước ', '13326', 'Ngân hàng Đông Nam Á', 'Bến Tre ', 'Ninh Thuận', '0723348427', '0831897273', 'jsev19@gmail.com', 'Duy Trung', '1997-05-02 10:00:29', NULL, '1983-12-16 18:40:14'),
('1737c16a-1277-1be3-3bc2-579daad24557', 'NV-5838', 'Ngô Thị Ngọc', '1960-09-25 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '31662772', '2021-02-02 23:20:57', 'Nghệ An ', 'Phó phòng', 'Lạng Sơn', '66776', 'Ngân hàng HDBank', 'Đắk Nông ', 'Bắc Kạn', '0870347299', '0353875299', 'Homer738@gmail.com', 'Minh Huy', '1993-10-08 18:54:44', 'An Yến', '2010-01-12 07:51:35'),
('17872e95-3d24-6d1a-32c2-579daad24557', 'NV-6783', 'Hoàng Mỹ Hoa', '1977-01-29 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '38281910', '1989-11-22 19:40:31', 'Lai Châu ', 'Quản lý', 'Lai Châu', '87365', 'Ngân hàng Phương Đông', 'Đồng Nai ', 'Bắc Ninh ', '0990822487', '0815784265', 'Aubrey_Daigle52@gmail.com', 'An Lâm ', '2017-08-29 06:57:54', 'Thị Vân', '2002-06-21 15:48:15'),
('184de98f-2046-1e3f-3377-d9ebc53aac3d', 'NV-6931', 'Sầm Văn Trung', '1953-05-22 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '71999150', '1995-03-13 07:01:33', 'Lạng Sơn ', 'Quản lý', 'Bến Tre ', '67444', 'Ngân hàng Á Châu', 'Đồng Nai ', 'Lạng Sơn', '0300797845', '0925885137', 'Conklin71@gmail.com', 'Duy Toản', '1970-10-17 05:37:30', 'Mộc Hà', '2014-08-09 03:12:32'),
('1894486a-2191-4a91-ccd2-89b22d10517e', 'NV-5462', 'Trần  Văn Toản', '1951-03-09 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '06545990', '1970-01-01 00:01:08', 'An Giang  ', 'Giám đốc', 'Đà Nẵng ', '31172', 'Ngân hàng Kỹ Thương Việt Nam', 'Nghệ An', 'Điện Biên ', '0795881415', '0867957766', 'lqwb72@gmail.com', 'Khánh Thảo', '2019-10-29 15:11:08', 'Thị Phương', '1991-01-24 06:38:55'),
('18baaac1-2b18-2317-b9d2-89b22d10517e', 'NV-9764', 'Quảng Văn Luân', '1966-11-20 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '08022762', '2019-04-12 12:54:50', 'Bà Rịa – Vũng Tàu ', 'Nhân viên', 'Tây Ninh', '51870', 'Ngân hàng Á Châu', 'Bến Tre ', 'Quảng Trị', '0836673689', '0807004447', 'Roland@gmail.com', 'Thị Anh', '1977-10-31 09:24:10', 'Văn Linh', '2009-02-04 00:47:17'),
('18bbd5d8-6c2d-154c-bad2-89b22d10517e', 'NV-6483', 'Lưu Thị Nhung', '1961-11-04 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '78362363', '1985-01-05 07:59:58', 'Quảng Ngãi ', 'Giám đốc', 'An Giang ', '13613', 'Ngân hàng Tiên Phong', 'Lào Cai', 'Quảng Ngãi', '0769444077', '0734806274', 'CarsonManuel41@gmail.com', 'An Sơn', '2020-07-25 22:13:48', 'Duy Nguyên', '1970-01-01 00:20:07'),
('18d2ec1b-61c5-1896-2ec2-579daad24557', 'NV-8959', 'Đoàn Anh Hương', '1957-10-01 00:00:00', 2, '469b3ece-744a-45d5-957d-e8c757976496', '65727173', '2001-05-14 05:35:46', 'Quảng Trị ', 'Trưởng phòng', 'Bình Thuận ', '83724', 'Ngân hàng Tiên Phong', 'Bắc Kạn', 'Nghệ An', '0819041634', '0875873239', 'xeue8282@gmail.com', 'Khánh Hiền', '1978-10-23 20:36:07', 'Khánh Tuấn', '2002-11-23 15:55:21'),
('1906737f-3aed-5704-1777-d9ebc53aac3d', 'NV-0295', 'Quách Duy Luân', '1981-06-16 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '31256416', '2013-08-20 05:19:21', 'Cao Bằng  ', 'Nhân viên cấp cao', 'Cao Bằng ', '16949', 'Ngân hàng Quân đội', 'Quảng Ninh', 'Đắk Nông ', '0897413682', '0954446272', 'SaundraLAkin@gmail.com', 'Khánh Quang', '1970-01-01 00:35:58', 'Khánh Luân', '2008-09-05 10:25:04'),
('19208572-271c-6122-3177-d9ebc53aac3d', 'NV-4385', 'Sơn Thị Hằng', '1951-12-21 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '20175116', '1970-01-01 00:05:55', 'Lạng Sơn ', 'Giám đốc', 'Nghệ An', '38930', 'Ngân hàng Kỹ Thương Việt Nam', 'Bình Dương ', 'Bắc Giang', '0848054596', '0318411838', 'Dillard41@misa.com', 'Khánh Nhung', '1970-01-01 00:00:05', NULL, '1970-07-30 23:01:22'),
('19256041-7623-2834-6df6-423b4e874d0f', 'NV-9646', 'Tán An Yến', '1984-06-09 00:00:00', 1, '142cb08f-7c31-21fa-8e90-67245e8b283e', '80553348', '1982-12-21 12:09:17', 'Tây Ninh ', 'Nhân viên', 'Tây Ninh', '64835', 'Ngân hàng Á Châu', 'Tây Ninh', 'Đồng Tháp ', '0994807784', '0593890691', 'DamianClegg@gmail.com', 'Ngọc Toản', '1970-01-01 00:06:47', NULL, '1970-01-01 00:06:04'),
('192b3b9d-5e60-3b13-5b80-7ed9d1ea06ea', 'NV-8979', 'Ngô Văn Toản', '1952-01-07 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '30102434', '1970-01-01 00:06:12', 'Quảng Ninh ', 'Thực tập sinh', 'Quảng Bình', '59024', 'Ngân hàng An Bình', 'Bình Thuận ', 'Lạng Sơn', '0557854172', '0816378192', 'tjly3150@gmail.com', 'Thị Thảo', '1981-06-08 16:33:44', 'Khánh Ngọc', '1975-10-01 15:13:07'),
('197fda97-5a35-781d-0e77-d9ebc53aac3d', 'NV-4057', 'Lương Văn Toản', '1997-02-27 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '39121694', '1977-10-25 20:48:43', 'Bạc Liêu  ', 'Phó phòng', 'Đồng Nai ', '73323', 'Ngân hàng Kỹ Thương Việt Nam', 'Bạc Liêu ', 'Cần Thơ ', '0840596373', '0798185500', 'ndjketfq_rjzwqjx@gmail.com', 'Thị Ngọc', '2021-05-15 19:30:54', 'Thị Nhung', '1993-12-01 05:34:08'),
('199db575-444b-2633-6880-7ed9d1ea06ea', 'NV-1664', 'Quán Ngọc Toản', '1965-12-15 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '52247961', '1999-02-14 23:06:17', 'Phú Thọ ', 'Trưởng phòng', 'Đồng Tháp ', '69199', 'Ngân hàng VPBank', 'Tây Ninh', 'Lào Cai', '0745462373', '0932407766', 'zftqs39@gmail.com', 'Mộc Phương', '1970-01-01 00:00:06', 'Văn Đạt', '1989-07-01 13:05:34'),
('1b05fdba-145b-7ab0-8d41-c1ec321fe728', 'NV-0888', 'Tào Thị Nhung', '1978-12-26 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '60235894', '2013-02-06 09:57:30', 'Lai Châu ', 'Quản lý', 'Nam Định', '56821', 'Ngân hàng PVcombank', 'Lào Cai', 'Bạc Liêu ', '0720102066', '0739162090', 'Alyssa_Daily@misa.com', 'Thị Huyền', '2010-02-10 09:51:45', 'Văn Toản', '1985-12-26 18:57:39'),
('1b972dfb-67eb-5f25-39c2-579daad24557', 'NV-8822', 'Quảng Văn Hưng.', '1982-06-27 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '94126666', '1970-09-12 13:33:48', 'Quảng Bình ', 'Trưởng phòng', 'Nghệ An', '37549', 'Ngân hàng Bắc Á', 'Quảng Nam', 'Nam Định', '0943851606', '0330043142', 'Bolling@gmail.com', 'Mộc Nhung', '1970-01-01 00:11:41', 'Văn Hưng.', '1970-01-01 00:01:19'),
('1c98cac7-2784-73af-43c2-579daad24557', 'NV-0919', 'Sùng Duy Hậu', '1951-01-29 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '50018060', '1970-01-01 00:00:29', 'Bắc Giang ', 'Phó phòng', 'Phú Thọ', '68533', 'Ngân hàng HDBank', 'Sóc Trăng', 'Quảng Nam', '0984869871', '0328088070', 'tyxb79@gmail.com', 'Mỹ Giang', '1985-11-12 01:36:42', 'Khánh ', '1985-06-24 04:58:06'),
('1ca4f185-7203-2a84-40c2-579daad24557', 'NV-3111', 'Tề Thị Nhung', '1982-09-06 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '07334287', '1976-12-08 12:08:05', 'Quảng Nam ', 'Nhân viên', 'Bắc Ninh ', '71839', 'Ngân hàng Đông Á', 'Kon Tum', 'Bình Dương ', '0810869133', '0964848351', 'Thaddeus_RFulmer@gmail.com', 'An ', '1997-07-27 23:46:34', 'Thị Phương', '1970-07-19 20:06:10'),
('1d05a704-5376-15ba-1477-d9ebc53aac3d', 'NV-2008', 'Tán Mộc Hoa', '1953-10-29 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '34709479', '1988-08-21 23:52:53', 'Ninh Thuận ', 'Nhân viên', 'Bình Phước ', '33975', 'Ngân hàng PVcombank', 'Lâm Đồng', 'Cần Thơ ', '0776212483', '0947644879', 'KandisAlves@gmail.com', 'Thị Yến', '1970-01-01 00:16:16', 'Duy Lâm ', '1970-01-01 00:00:39'),
('1d21993b-3612-2485-1035-60b3ebf808a9', 'NV-5951', 'Tán Mỹ Anh', '1951-02-27 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '76138324', '1970-01-01 00:00:58', 'Lạng Sơn ', 'Trưởng phòng', 'Ninh Bình', '23772', 'Ngân hàng Bắc Á', 'Bình Định ', 'Bắc Kạn', '0952806222', '0882828843', 'DeidraSeaton685@gmail.com', 'Ngọc Thảo', '1996-05-30 00:53:27', 'Khánh Hạnh', '1970-01-01 00:00:38'),
('1dc115ba-6479-33a7-44c2-579daad24557', 'NV-8027', 'Đặng Ngọc Nam ', '1994-12-28 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '99437186', '2011-12-01 18:51:37', 'Điện Biên  ', 'Nhân viên', 'Nghệ An', '63334', 'Ngân hàng Bản Việt', 'Phú Thọ', 'Bình Dương ', '0508951943', '0937010003', 'Cleveland@misa.com', 'Duy Linh', '1970-07-15 12:43:26', 'Duy Lâm ', '1970-01-01 00:00:04'),
('1e0613d9-772c-28c1-9541-c1ec321fe728', 'NV-3600', 'Tào An Hương', '1951-01-07 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '89180277', '1970-01-01 00:00:07', 'Đắk Lắk  ', 'Nhân viên', 'Nam Định', '12433', 'Ngân hàng An Bình', 'An Giang ', 'Quảng Bình', '0309618228', '0559087069', 'Burks@gmail.com', 'Ngọc Nhung', '1980-05-15 04:11:19', 'Duy Huy', '1970-01-01 00:00:28'),
('1e5ce342-2eec-79a4-5380-7ed9d1ea06ea', 'NV-5471', 'Bùi Mộc Nga', '1980-06-13 00:00:00', 1, '142cb08f-7c31-21fa-8e90-67245e8b283e', '45574477', '1990-08-14 07:12:43', 'Bình Phước  ', 'Trưởng phòng', 'Ninh Bình', '17620', 'Ngân hàng VPBank', 'Nam Định', 'Phú Thọ', '0529368820', '0802181815', 'Matthew_Briseno716@gmail.com', 'Minh Tuấn', '2005-08-14 04:07:20', 'Thị Hằng', '1970-12-13 13:15:06'),
('1e5e96fa-5d7a-599d-27c2-579daad24557', 'NV-6724', 'Sầm Văn Nguyên', '1966-11-30 00:00:00', 2, '469b3ece-744a-45d5-957d-e8c757976496', '53506622', '1972-02-18 11:00:46', 'Quảng Trị ', 'Thực tập sinh', 'Đồng Tháp ', '64201', 'Ngân hàng An Bình', 'Bình Thuận ', 'Điện Biên ', '0757730365', '0851944864', 'WilberLaney@misa.com', 'Khánh Trang', '1970-01-01 00:08:53', 'Ngọc Hiếu', '1986-07-17 05:10:18'),
('1f85f165-3ed3-370a-b7d2-89b22d10517e', 'NV-9583', 'Lục Ngọc Toản', '1956-01-13 00:00:00', 2, '469b3ece-744a-45d5-957d-e8c757976496', '44550167', '1994-10-19 09:16:03', 'Bắc Kạn ', 'Nhân viên cấp cao', 'Đắk Nông ', '58769', 'Ngân hàng Á Châu', 'Quảng Trị', 'Đắk Nông ', '0312653319', '0843311583', 'Fulton@gmail.com', 'Thị Hà', '1970-01-01 00:00:04', 'Anh Tùng', '1970-01-01 00:09:08'),
('1f88699a-3e19-718a-d81d-086412a8ea97', 'NV-6753', 'Quán An Nhung', '1962-09-16 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '88545543', '2021-02-09 00:19:35', 'Ninh Thuận ', 'Nhân viên', 'Phú Thọ', '46345', 'Ngân hàng Nam Á', 'Bắc Ninh ', 'Ninh Bình', '0710314539', '0363174247', 'Velazquez@gmail.com', 'Ngọc Nhung', '2001-12-05 22:56:52', 'Anh Cường', '2021-06-27 20:22:54'),
('1fbf8e6f-17d3-6a04-2180-de64d090a2c2', 'NV-4759', 'Đinh Văn Toản', '1954-12-02 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '06060292', '2002-12-04 01:40:04', 'Quảng Nam ', 'Phó phòng', 'Bình Thuận ', '40550', 'Ngân hàng Đông Nam Á', 'Bắc Ninh ', 'Ninh Thuận', '0909110296', '0396951167', 'Shelby.A_Bean2@misa.com', 'An Toản', '1970-01-01 00:00:05', 'Ngọc Hằng', '2007-07-25 17:54:02'),
('1fecd07f-2488-638c-8141-c1ec321fe728', 'NV-2522', 'Nguyễn Văn Tùng', '1967-06-17 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '21742643', '2017-03-10 15:16:01', 'Điện Biên  ', 'Phó phòng', 'Lai Châu', '98417', 'Ngân hàng Bắc Á', 'An Giang ', 'Sơn La', '0385279496', '0817233796', 'Isbell@gmail.com', 'Thị Hiền', '1979-07-19 00:26:32', 'Mộc Yến', '2016-09-15 19:59:20'),
('201b9639-5997-303c-5880-7ed9d1ea06ea', 'NV-2162', 'Tào Mộc Mai', '1960-06-08 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '68082951', '1994-12-21 04:06:39', 'Bắc Ninh  ', 'Nhân viên cấp cao', 'Quảng Nam', '90568', 'Ngân hàng Nam Á', 'Bình Phước ', 'Phú Yên', '0339094950', '0551714812', 'Tellez471@gmail.com', 'Khánh Thảo', '1980-09-29 01:43:32', NULL, '1973-01-15 05:15:53'),
('2107e2a5-49f8-237b-5780-7ed9d1ea06ea', 'NV-6867', 'Quán Văn Lâm ', '1968-05-26 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '07800026', '1970-03-16 20:04:57', 'Bắc Kạn ', 'Giám đốc', 'Quảng Ninh', '55976', 'Ngân hàng Á Châu', 'Đồng Tháp ', 'Bà Rịa – Vũng Tàu', '0382882966', '0396272352', 'Acker@gmail.com', 'Mộc Anh', '1970-01-01 00:00:39', 'Văn Toản', '1987-04-01 22:22:14'),
('2111e63d-50f8-6b2b-6980-7ed9d1ea06ea', 'NV-7248', 'Quang Ngọc Toản', '1951-02-18 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '88431569', '1970-01-01 00:00:49', 'Kon Tum ', 'Giám đốc', 'Bến Tre ', '02299', 'Ngân hàng PVcombank', 'Lào Cai', 'Lạng Sơn', '0334263913', '0737753007', 'JeniceVogt@gmail.com', 'Văn Cương', '2007-07-27 04:52:55', 'Duy Đạt', '1970-01-01 02:38:24'),
('212a5f62-4eb8-203c-4035-0028ed526dd0', 'NV-9549', 'Mai Duy Cương', '1991-02-27 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '91502355', '2019-03-10 13:29:57', 'Bắc Ninh  ', 'Giám đốc', 'Nghệ An', '39213', 'Ngân hàng Nam Á', 'Bình Phước ', 'Bến Tre ', '0901492883', '0727800026', 'Collier@gmail.com', 'Ngọc Thảo', '2020-08-16 20:10:06', 'Mộc Hoa', '1987-01-31 22:24:24'),
('214977d8-66ff-5762-1335-60b3ebf808a9', 'NV-2040', 'Phạm Thị Vân', '1951-03-16 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '81658310', '1970-01-01 00:01:15', 'Tây Ninh ', 'Nhân viên', 'Cà Mau ', '27046', 'Ngân hàng Phương Đông', 'Kon Tum', 'Bắc Giang', '0946968568', '0813699953', 'StephaniApodaca@gmail.com', 'Khánh Hiền', '2000-09-19 01:41:05', 'Văn Hiệp', '1977-08-21 12:26:55'),
('21ae5078-5e68-3790-6af6-423b4e874d0f', 'NV-5824', 'Hoàng Ngọc Thảo', '1951-01-12 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '16357680', '1970-01-01 00:00:12', 'Điện Biên  ', 'Thực tập sinh', 'Ninh Thuận', '09234', 'Ngân hàng An Bình', 'Nghệ An', 'Đắk Lắk ', '0383361044', '0894025105', 'Brain.Cope44@gmail.com', 'Văn Đạt', '2007-09-02 03:34:23', 'Hải Hiếu', '1970-01-01 01:12:19'),
('22732821-2015-1da3-4335-0028ed526dd0', 'NV-2395', 'Sái Mộc Hà', '1953-03-29 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '80386436', '1984-08-13 10:08:28', 'Bạc Liêu  ', 'Giám đốc', 'Cà Mau ', '85375', 'Ngân hàng Bắc Á', 'Quảng Ninh', 'Lâm Đồng', '0985453975', '0567640612', 'uvjc2@misa.com', 'Ngọc Tuấn', '1986-02-04 20:16:43', NULL, '1970-01-01 00:01:37'),
('22bba567-6206-6bf1-0c35-60b3ebf808a9', 'NV-8193', 'Tán Ngọc Duy', '1964-01-01 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '92705014', '2003-07-27 23:56:46', 'Bắc Ninh  ', 'Giám đốc', 'Quảng Nam', '37291', 'Ngân hàng VPBank', 'Nghệ An', 'Quảng Ngãi', '0858507058', '0941586013', 'BauerC258@misa.com', 'Văn Huy', '1970-01-01 00:00:08', 'An Bảo ', '2009-02-22 13:11:37'),
('22cb30ef-3311-51f7-e21d-086412a8ea97', 'NV-3727', 'Lê An Nga', '1975-06-09 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '26745645', '1995-12-28 17:27:29', 'Nghệ An ', 'Quản lý', 'Tây Ninh', '18251', 'Ngân hàng VPBank', 'An Giang ', 'Cần Thơ ', '0551880822', '0582721961', 'SheilaG_Abreu@gmail.com', 'Mộc Hà', '1987-06-18 16:59:05', 'Hải Nam ', '1970-01-01 00:00:58'),
('22df58b0-55d2-6108-2480-de64d090a2c2', 'NV-0810', 'Sầm Duy Linh', '1966-10-25 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '83114221', '1970-01-01 01:36:17', 'Sơn La ', 'Nhân viên', 'Ninh Bình', '22988', 'Ngân hàng Đông Nam Á', 'Đồng Nai ', 'Bà Rịa – Vũng Tàu', '0309203748', '0706599747', 'AcevedoJ647@gmail.com', 'Mộc Yến', '1999-06-23 16:21:01', 'An Toản', '1974-12-27 21:38:38'),
('22f0091b-523a-6c8e-4c35-0028ed526dd0', 'NV-1395', 'Quàng An Dũng', '1977-06-23 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '08814459', '1970-01-01 02:41:11', 'Ninh Bình ', 'Thực tập sinh', 'Bình Định ', '67181', 'Ngân hàng Bản Việt', 'Đắk Lắk ', 'Nghệ An', '0786019714', '0995016228', 'IraDelarosa657@gmail.com', 'Văn Toản', '2018-08-07 13:58:47', 'Mộc Thảo', '1970-01-01 00:00:42'),
('231ea7f8-1468-6e29-5235-0028ed526dd0', 'NV-3126', 'Lê Hải Lộc ', '1955-02-17 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '79299760', '1970-01-01 00:25:09', 'Lâm Đồng ', 'Phó phòng', 'Quảng Ngãi', '01034', 'Ngân hàng Bắc Á', 'Cà Mau ', 'Sơn La', '0924401499', '0395156589', 'Ferreira@misa.com', 'Thị Hạnh', '2010-07-18 21:55:31', 'Ngọc Ngọc', '2003-02-08 02:02:42'),
('233d36ab-4bd0-431e-78f6-423b4e874d0f', 'NV-5966', 'Phạm Thị Hương', '1999-06-09 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '76793538', '2012-10-19 16:37:32', 'Đắk Nông  ', 'Trưởng phòng', 'Cao Bằng ', '33879', 'Ngân hàng An Bình', 'Lạng Sơn', 'Nam Định', '0524952926', '0767018998', 'Angulo@gmail.com', 'Văn Toản', '2021-04-19 08:05:19', 'Ngọc Toản', '1996-07-13 19:28:22'),
('234865cb-5d80-7244-70f6-423b4e874d0f', 'NV-9165', 'Ngô Khánh Hiếu', '1951-02-10 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '77582514', '1970-01-01 00:00:41', 'Lâm Đồng ', 'Phó phòng', 'Ninh Thuận', '33635', 'Ngân hàng PVcombank', 'Ninh Bình', 'Quảng Ngãi', '0786651089', '0387593790', 'gtzzc8@misa.com', 'Văn Tùng', '1970-06-15 02:34:06', 'Mộc Anh', '1986-05-11 02:14:07'),
('2356a2d8-7751-6f97-66f6-423b4e874d0f', 'NV-9969', 'Võ An Linh', '2000-05-18 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '67754566', '1989-04-17 17:58:43', 'Ninh Thuận ', 'Trưởng phòng', 'Kon Tum', '40587', 'Ngân hàng Đông Nam Á', 'Kon Tum', 'Quảng Nam', '0975692270', '0964650027', 'Hudgens@misa.com', 'Ngọc Dũng', '1994-12-25 03:49:20', 'Văn Bảo ', '1970-01-01 00:14:48'),
('237092c3-5684-7bb6-0a35-60b3ebf808a9', 'NV-2747', 'Mai An Hiếu', '1986-10-26 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '03981036', '1987-07-08 02:02:48', 'Lâm Đồng ', 'Nhân viên cấp cao', 'Bắc Giang', '97928', 'Ngân hàng Kỹ Thương Việt Nam', 'Cao Bằng ', 'Cao Bằng ', '0523728696', '0836861495', 'Lauren.PMintz@gmail.com', 'Mỹ Hương', '1998-03-10 02:52:44', 'Ngọc Yến', '2011-04-16 07:15:03'),
('244b1b16-56fc-1f92-73f6-423b4e874d0f', 'NV-6589', 'Trần  Mỹ Hạnh', '1951-03-18 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '97462999', '2008-06-24 05:49:57', 'Tây Ninh ', 'Nhân viên cấp cao', 'Lai Châu', '03322', 'Ngân hàng HDBank', 'Đắk Lắk ', 'Sóc Trăng', '0884991508', '0742237010', 'Ladner@gmail.com', 'Khánh Nam ', '1970-01-01 00:00:13', 'Thị Hạnh', '1991-08-30 05:01:15'),
('255b28ba-2177-6baf-0835-60b3ebf808a9', 'NV-4859', 'Tấn Khánh Hương', '1970-08-06 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '90505666', '2020-04-12 21:51:09', 'Lạng Sơn ', 'Nhân viên cấp cao', 'Đồng Nai ', '94030', 'Ngân hàng Quân đội', 'Nam Định', 'Điện Biên ', '0833544558', '0534735050', 'Gould@gmail.com', 'Khánh Nhung', '1988-09-21 18:31:00', 'Khánh Linh', '1970-01-01 02:25:22'),
('256c7bfd-6225-4caa-3077-d9ebc53aac3d', 'NV-2687', 'Ngô Hải Duy', '1954-11-18 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '50330037', '2015-05-17 00:25:09', 'Lạng Sơn ', 'Giám đốc', 'Kon Tum', '96132', 'Ngân hàng Nam Á', 'Bắc Kạn', 'Lai Châu', '0882970864', '0828765203', 'Ferrell@gmail.com', 'Văn Toản', '1986-04-22 07:06:55', 'Mộc Trang', '1982-05-11 07:54:21'),
('257f267d-1259-4c3b-2e80-de64d090a2c2', 'NV-4463', 'Sầm Ngọc Linh', '1999-03-06 00:00:00', 1, '142cb08f-7c31-21fa-8e90-67245e8b283e', '76288367', '1989-04-26 10:22:45', 'Nam Định ', 'Nhân viên cấp cao', 'Bình Dương ', '76179', 'Ngân hàng Đông Á', 'Bắc Giang', 'Đắk Lắk ', '0854860600', '0360341462', 'Lesley_RLira@misa.com', 'Văn Hiệp', '1970-01-01 00:01:33', 'Mỹ Hằng', '1971-09-24 11:47:55'),
('26942456-25a8-5ec2-8b41-c1ec321fe728', 'NV-6447', 'Sái Duy Toản', '1990-07-23 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '80333392', '1986-04-27 23:02:30', 'Đắk Lắk  ', 'Trưởng phòng', 'Cà Mau ', '41320', 'Ngân hàng Bản Việt', 'Điện Biên ', 'Bến Tre ', '0702683680', '0886609106', 'Allison@gmail.com', 'Ngọc Ngọc', '1970-01-01 00:01:31', 'Văn Nhật', '2010-03-10 22:53:23'),
('27318165-703a-31a0-3277-d9ebc53aac3d', 'NV-3274', 'Lưu Minh Nhật', '1983-12-31 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '48793970', '1994-03-16 00:19:32', 'Lào Cai ', 'Giám đốc', 'Quảng Ninh', '37125', 'Ngân hàng Đông Nam Á', 'Quảng Trị', 'Sơn La', '0837446651', '0771302236', 'ClarettaAnglin@gmail.com', 'Khánh Thảo', '1991-05-24 04:14:49', 'Thị Hương', '2014-05-26 11:54:38'),
('27e60da2-385e-6804-8441-c1ec321fe728', 'NV-7021', 'Sơn Mỹ Hằng', '1980-02-14 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '59745631', '2001-10-30 14:23:02', 'Bình Dương  ', 'Thực tập sinh', 'Phú Thọ', '62914', 'Ngân hàng Kỹ Thương Việt Nam', 'Đắk Lắk ', 'Bình Dương ', '0810912479', '0748465477', 'Sandoval@gmail.com', 'Duy Toản', '1982-09-26 15:28:02', 'Khánh Thảo', '1994-10-11 09:49:14'),
('281af570-5697-2b8d-6b80-7ed9d1ea06ea', 'NV-3223', 'Đinh Duy Toản', '1976-06-17 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '96908722', '2014-09-24 06:10:31', 'Quảng Trị ', 'Nhân viên cấp cao', 'Bắc Ninh ', '73342', 'Ngân hàng Phương Đông', 'Sóc Trăng', 'Nam Định', '0810346163', '0715952780', 'Lundy69@gmail.com', 'Khánh Thảo', '1999-04-23 23:48:35', 'Văn ', '1983-02-10 08:16:30'),
('285d6b44-3b0c-4697-e01d-086412a8ea97', 'NV-2621', 'Phan Duy Toản', '1951-01-04 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '44457796', '1970-01-01 00:00:04', 'Sơn La ', 'Quản lý', 'Bắc Kạn', '18787', 'Ngân hàng PVcombank', 'Ninh Thuận', 'Lâm Đồng', '0567021014', '0969211728', 'pkzldpty_kona@gmail.com', 'Văn Tùng', '1970-01-01 00:01:20', 'Thị Hằng', '1970-01-01 02:18:45'),
('28692b18-2ec1-574b-6780-7ed9d1ea06ea', 'NV-9750', 'Quách Văn Nhật', '1956-05-07 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '68104566', '2015-08-12 00:39:20', 'Lạng Sơn ', 'Phó phòng', 'Đắk Nông ', '14521', 'Ngân hàng HDBank', 'Lâm Đồng', 'Bến Tre ', '0537116484', '0786461338', 'Racquel.Babin9@misa.com', 'Mộc Thảo', '1994-02-18 07:21:49', NULL, '1970-01-01 00:00:51'),
('2872c174-68d3-29c1-4935-0028ed526dd0', 'NV-1965', 'Đặng Duy Hậu', '1952-10-04 00:00:00', 1, '142cb08f-7c31-21fa-8e90-67245e8b283e', '19795550', '1970-01-01 00:10:43', 'Ninh Bình ', 'Nhân viên cấp cao', 'Bà Rịa – Vũng Tàu', '34011', 'Ngân hàng Bắc Á', 'Lạng Sơn', 'Phú Yên', '0802470001', '0743447193', 'ClydeAvila636@gmail.com', 'Thị Nga', '2013-08-14 10:36:28', 'Ngọc Thảo', '1986-01-11 20:05:41'),
('28a16581-1fd1-546b-1677-d9ebc53aac3d', 'NV-5440', 'Trần  Thị Nhung', '1959-07-21 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '94218874', '1978-11-07 23:43:08', 'Lạng Sơn ', 'Phó phòng', 'Quảng Trị', '06858', 'Ngân hàng VPBank', 'Phú Thọ', 'Lâm Đồng', '0384320212', '0325074460', 'MarianneSutton66@misa.com', 'Mộc Hằng', '1972-11-29 07:02:40', 'Thị Nhung', '1970-01-01 00:00:01'),
('28cd1599-63bf-785f-4f80-7ed9d1ea06ea', 'NV-7493', 'Đinh Khánh Trang', '1961-03-06 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '93523493', '1985-03-22 00:06:07', 'Đắk Nông  ', 'Giám đốc', 'Đắk Lắk ', '83127', 'Ngân hàng Á Châu', 'Đồng Nai ', 'Lào Cai', '0309156182', '0743253506', 'WaltonGolden1@misa.com', 'Hải Toản', '2019-02-12 00:42:46', 'Mộc Trang', '1997-04-01 06:53:29'),
('29dcec4b-6bba-5878-1735-60b3ebf808a9', 'NV-2683', 'Phan Minh Toản', '1984-11-05 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '30275148', '1974-07-16 15:59:09', 'Bình Thuận  ', 'Phó phòng', 'Điện Biên ', '91337', 'Ngân hàng HDBank', 'Phú Yên', 'Nghệ An', '0991712616', '0810517905', 'Swanson4@gmail.com', 'Mộc Nhung', '2021-05-13 22:03:57', 'Mộc Nhung', '1991-10-21 11:50:53'),
('2afb2146-430d-394b-3d35-0028ed526dd0', 'NV-5559', 'Nguyễn Duy Linh', '1966-03-18 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '64429262', '1990-01-15 01:27:32', 'Đà Nẵng  ', 'Phó phòng', 'Sơn La', '49011', 'Ngân hàng Bản Việt', 'Bắc Giang', 'Lai Châu', '0862958072', '0531477564', 'hjsjcmeu4972@misa.com', 'Mộc Hiền', '1970-01-01 00:00:44', 'Văn Toản', '2014-03-07 23:35:12'),
('2bd27090-2727-2b8e-2f80-de64d090a2c2', 'NV-2740', 'Lý Văn Lộc ', '1953-04-07 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '49749191', '1970-01-01 00:13:48', 'An Giang  ', 'Giám đốc', 'Ninh Thuận', '85233', 'Ngân hàng Kỹ Thương Việt Nam', 'Lâm Đồng', 'Nghệ An', '0716838976', '0855686093', 'Jay334@misa.com', 'Duy Quang', '1970-01-01 02:02:20', 'Anh Lộc ', '2008-08-01 17:32:41'),
('2bd927cf-7faf-452e-4535-0028ed526dd0', 'NV-7434', 'Huỳnh Mộc Vân', '1996-07-26 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '09721995', '2010-03-27 13:00:35', 'Bắc Kạn ', 'Trưởng phòng', 'Nam Định', '13788', 'Ngân hàng Tiên Phong', 'Đồng Tháp ', 'Sơn La', '0872558980', '0861571361', 'uwmagfvd.pegc@misa.com', 'Văn Tuấn', '1988-07-24 09:58:25', 'Anh Dũng', '1973-05-20 15:15:37'),
('2c06d3cb-7ef7-4462-5e80-7ed9d1ea06ea', 'NV-8220', 'Phạm Anh Anh', '1951-08-23 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '06861811', '1970-01-01 00:03:55', 'Sóc Trăng ', 'Nhân viên', 'Bắc Kạn', '18731', 'Ngân hàng Hàng Hải Việt Nam', 'Bà Rịa – Vũng Tàu', 'Đà Nẵng ', '0571665655', '0961823940', 'Tuggle@gmail.com', 'Hải ', '1973-05-06 13:25:58', 'Khánh Trang', '2008-10-18 20:11:31'),
('2c14d4bf-4fdf-22d0-cbd2-89b22d10517e', 'NV-0534', 'Tấn Anh Cường', '2000-06-24 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '68471644', '1992-07-03 18:37:06', 'Ninh Bình ', 'Nhân viên', 'Ninh Thuận', '54661', 'Ngân hàng PVcombank', 'Đà Nẵng ', 'Quảng Trị', '0398974271', '0318747178', 'MargeneRush638@misa.com', 'Duy Toản', '1990-04-25 00:11:02', 'Minh Tùng', '1970-01-01 02:27:57'),
('2c380a42-1611-28c2-3ac2-579daad24557', 'NV-6596', 'Hoàng Ngọc Hà', '1952-10-17 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '33073927', '1980-07-25 16:12:26', 'Bạc Liêu  ', 'Thực tập sinh', 'Quảng Ngãi', '86148', 'Ngân hàng An Bình', 'Bắc Kạn', 'Quảng Ninh', '0566916262', '0744597778', 'Layne@gmail.com', 'Mộc Nga', '1972-09-01 07:02:01', 'Mỹ Yến', '1970-01-01 00:00:07'),
('2d3ae261-2b44-7713-41c2-579daad24557', 'NV-4678', 'Quán Khánh ', '1985-01-10 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '29277236', '2010-01-12 00:46:54', 'Lào Cai ', 'Giám đốc', 'Nam Định', '12408', 'Ngân hàng Bản Việt', 'Bắc Ninh ', 'Quảng Bình', '0791022046', '0737653288', 'Martz7@gmail.com', 'Duy Linh', '1997-11-06 09:20:24', 'Minh Duy', '2014-05-20 15:42:19'),
('2dd6b3a0-2350-1230-1835-60b3ebf808a9', 'NV-4992', 'Đặng Văn Đạt', '1951-01-26 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '38898050', '1970-01-01 00:00:26', 'Quảng Nam ', 'Quản lý', 'Phú Thọ', '53066', 'Ngân hàng Á Châu', 'Đắk Lắk ', 'Ninh Bình', '0380976759', '0357142913', 'Acevedo@misa.com', 'Mỹ Linh', '2016-04-10 03:33:34', NULL, '2003-11-13 05:38:20'),
('2ee950fb-4256-49aa-e41d-086412a8ea97', 'NV-7110', 'Hồ Thị Hà', '1970-04-15 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '39987501', '1970-01-01 01:57:25', 'Quảng Nam ', 'Trưởng phòng', 'Đắk Nông ', '81544', 'Ngân hàng Đông Á', 'Bình Định ', 'Quảng Ngãi', '0539155249', '0980530468', 'Fong96@misa.com', 'Ngọc Hà', '2011-06-02 09:36:49', 'Mỹ Giang', '2016-05-09 05:46:49'),
('2efc0ff3-37c0-286f-bbd2-89b22d10517e', 'NV-6723', 'Ngô An Giang', '1976-06-07 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '17121200', '1973-06-29 10:01:02', 'Bà Rịa – Vũng Tàu ', 'Giám đốc', 'Bà Rịa – Vũng Tàu', '70303', 'Ngân hàng Bắc Á', 'Nghệ An', 'Quảng Nam', '0759239278', '0852767483', 'ufsjnfah_buej@misa.com', 'Khánh Hiếu', '1998-06-12 05:47:59', 'Văn Đạt', '2001-10-28 19:47:42'),
('2f25e35e-15fb-71e4-4e35-0028ed526dd0', 'NV-4539', 'Huỳnh Duy Cương', '1951-01-06 00:00:00', 2, '469b3ece-744a-45d5-957d-e8c757976496', '03187009', '1970-01-01 00:00:06', 'Đà Nẵng  ', 'Phó phòng', 'Bạc Liêu ', '44147', 'Ngân hàng Hàng Hải Việt Nam', 'Đồng Tháp ', 'Bình Thuận ', '0540943129', '0317333907', 'JacobVWooten485@misa.com', 'Khánh Linh', '1973-06-25 14:56:15', 'Anh Nhật', '1970-01-01 01:47:09'),
('2f43fc9d-1f7a-25fc-5280-7ed9d1ea06ea', 'NV-1288', 'Lê Mỹ Linh', '1988-11-18 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '99596511', '2012-03-08 01:56:34', 'Quảng Bình ', 'Giám đốc', 'Đồng Nai ', '62140', 'Ngân hàng VPBank', 'Lai Châu', 'Bắc Kạn', '0933471303', '0760347094', 'Alton.Chapa588@misa.com', 'An Toản', '1999-07-31 06:15:03', 'Văn Tuấn', '1970-01-01 00:08:52'),
('2f4cc91d-6f13-4b4c-1c80-de64d090a2c2', 'NV-4407', 'Nguyễn Duy Trung', '1953-08-02 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '73685040', '1970-01-01 00:15:45', 'Lâm Đồng ', 'Phó phòng', 'Quảng Bình', '26687', 'Ngân hàng Phương Đông', 'Điện Biên ', 'Sóc Trăng', '0725839579', '0345612580', 'CarminaBrumfield685@gmail.com', 'Thị Hạnh', '2009-08-11 05:10:08', 'Thị Hằng', '1970-01-01 00:01:38'),
('2fde0921-432c-64c5-0935-60b3ebf808a9', 'NV-1955', 'Lương Khánh Lâm ', '1998-08-06 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '24753779', '2017-03-10 08:07:44', 'Lâm Đồng ', 'Nhân viên', 'Quảng Nam', '52756', 'Ngân hàng Nam Á', 'An Giang ', 'Bạc Liêu ', '0540913512', '0346377652', 'Sheldon.Aldridge@misa.com', 'Khánh Nhung', '2000-01-23 19:43:40', 'Thị Trang', '1990-11-05 01:26:04'),
('3017e692-73fb-6331-6a80-7ed9d1ea06ea', 'NV-8317', 'Phan Mộc Hương', '1959-06-26 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '19374658', '1997-05-26 03:33:44', 'Tây Ninh ', 'Nhân viên', 'An Giang ', '10105', 'Ngân hàng Hàng Hải Việt Nam', 'Bình Phước ', 'Cà Mau ', '0565184307', '0884666403', 'ShirlyStacy17@gmail.com', 'Minh Toản', '1993-10-16 16:30:36', 'Mộc Thu', '1989-11-04 09:26:17'),
('31629133-61f6-7765-1535-60b3ebf808a9', 'NV-7009', 'Đặng Anh Thảo', '1954-02-22 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '91358488', '1987-02-27 10:51:27', 'Đắk Lắk  ', 'Nhân viên', 'Phú Yên', '43124', 'Ngân hàng Bản Việt', 'Bình Thuận ', 'Bà Rịa – Vũng Tàu', '0789715526', '0762095324', 'Layton393@gmail.com', 'Thị Nhung', '1971-12-09 15:17:09', 'Duy Tuấn', '1998-10-20 10:31:07'),
('31ae1818-7baf-1872-1e77-d9ebc53aac3d', 'NV-7228', 'Sử Anh Tùng', '1951-01-01 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '54012065', '1970-01-01 00:00:01', 'Sóc Trăng ', 'Quản lý', 'Ninh Bình', '18052', 'Ngân hàng Á Châu', 'Bạc Liêu ', 'Đồng Tháp ', '0586976100', '0743998917', 'coosw0205@gmail.com', 'Duy Hậu', '2004-10-07 17:39:58', 'Khánh Yến', '1970-01-01 00:00:39'),
('322105dd-142f-392d-2fc2-579daad24557', 'NV-2333', 'Võ Văn Cương', '1963-09-01 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '59725639', '1980-10-31 12:16:39', 'Ninh Thuận ', 'Trưởng phòng', 'Bình Định ', '09788', 'Ngân hàng Hàng Hải Việt Nam', 'Cao Bằng ', 'Kon Tum', '0997969874', '0783491562', 'Darin_Tolbert424@misa.com', 'Thị Phương', '2011-12-06 01:59:16', 'Thị Hạnh', '2007-08-12 18:42:36'),
('324ac33a-77c5-13a5-0535-60b3ebf808a9', 'NV-8124', 'Lưu Hải Linh', '1951-01-18 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '37567192', '1970-01-01 00:00:18', 'Phú Yên ', 'Giám đốc', 'An Giang ', '02850', 'Ngân hàng Đông Á', 'Nam Định', 'Cà Mau ', '0892545025', '0939527034', 'zjnogqkv_umtich@gmail.com', 'Anh Huyền', '1970-01-01 00:00:51', 'Văn Toản', '1973-12-10 18:23:09'),
('329b5332-34e3-1ae4-6ef6-423b4e874d0f', 'NV-9629', 'Vũ Ngọc Hằng', '1962-08-17 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '01358824', '1993-02-08 00:28:30', 'Bình Định  ', 'Thực tập sinh', 'Quảng Bình', '07389', 'Ngân hàng Quân đội', 'Cà Mau ', 'Đắk Lắk ', '0387195981', '0377541938', 'ffgha6537@gmail.com', 'Duy Cương', '2017-10-11 03:31:28', 'Văn Toản', '1996-09-01 15:08:23'),
('32d33559-61a5-4afd-d91d-086412a8ea97', 'NV-0761', 'Bùi Văn Toản', '1974-09-28 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '93039912', '2006-12-18 23:37:05', 'Ninh Thuận ', 'Nhân viên', 'Bình Phước ', '76743', 'Ngân hàng Phương Đông', 'Lai Châu', 'Quảng Trị', '0572598325', '0522641040', 'MalikEaston@gmail.com', 'Duy Cương', '1980-01-31 18:41:07', 'Ngọc Yến', '1985-12-24 02:50:36'),
('32e3be81-3548-6f8f-6380-7ed9d1ea06ea', 'NV-3433', 'Quảng Văn Huy', '1970-06-03 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '22336886', '1981-04-19 09:27:05', 'Nam Định ', 'Nhân viên', 'Bình Dương ', '77484', 'Ngân hàng Đông Á', 'Nam Định', 'Cần Thơ ', '0924043236', '0537718883', 'ReginaldBostick@gmail.com', 'Anh Nhung', '2007-08-15 17:15:26', NULL, '2019-01-17 18:26:35'),
('3304dddb-1b72-607f-25c2-579daad24557', 'NV-0638', 'Mai Minh ', '1979-01-16 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '56857082', '1973-01-13 15:40:35', 'Bắc Kạn ', 'Thực tập sinh', 'Bình Phước ', '31170', 'Ngân hàng Tiên Phong', 'Bến Tre ', 'Ninh Thuận', '0927549424', '0515474996', 'Conrad_Frizzell61@gmail.com', 'Văn Toản', '1982-01-29 09:15:34', 'Thị Hằng', '1989-12-30 18:05:31'),
('33589ecb-33ac-28c7-9241-c1ec321fe728', 'NV-0373', 'Đinh Hải Lộc ', '1955-04-15 00:00:00', 1, '142cb08f-7c31-21fa-8e90-67245e8b283e', '72040282', '2005-09-04 00:02:13', 'Quảng Ninh ', 'Quản lý', 'Quảng Trị', '73944', 'Ngân hàng Á Châu', 'Cao Bằng ', 'Đắk Nông ', '0811781025', '0750012267', 'AdolfoSmothers@gmail.com', 'Ngọc Thảo', '1970-01-01 00:01:25', 'Anh Cường', '1997-12-09 14:46:20'),
('337faf61-662b-461a-69f6-423b4e874d0f', 'NV-8557', 'Hồ Văn Nguyên', '1951-02-16 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '44535260', '1970-01-01 00:00:47', 'Ninh Thuận ', 'Trưởng phòng', 'Bạc Liêu ', '98422', 'Ngân hàng HDBank', 'Đồng Tháp ', 'Ninh Thuận', '0591748487', '0785398663', 'Francisco_Cousins@gmail.com', 'Văn Đạt', '1974-02-23 11:31:02', 'Mỹ Hương', '2019-07-30 06:40:01'),
('33ec4fea-4c03-3191-3ec2-579daad24557', 'NV-0850', 'Đặng Văn ', '1966-11-05 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '77122295', '1997-09-27 23:30:51', 'Quảng Nam ', 'Nhân viên', 'Phú Yên', '19221', 'Ngân hàng Nam Á', 'Bạc Liêu ', 'Lâm Đồng', '0754825770', '0375019942', 'Beaulieu@misa.com', 'An Phương', '1989-01-06 18:34:35', 'Thị Hằng', '2014-08-16 12:43:59'),
('34d0e3b5-6d5f-1fd7-0635-60b3ebf808a9', 'NV-8547', 'Sơn Văn Hiệp', '1951-02-24 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '13022178', '1970-01-01 00:00:55', 'Cần Thơ  ', 'Thực tập sinh', 'Kon Tum', '16590', 'Ngân hàng An Bình', 'Lào Cai', 'Nghệ An', '0312761951', '0377008855', 'Clancy776@misa.com', 'Minh Nam ', '1980-08-21 00:35:33', 'Duy Tuấn', '1997-04-15 19:08:05'),
('34e55501-2213-19af-6d80-7ed9d1ea06ea', 'NV-8419', 'Bùi Văn ', '1964-10-03 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '88381543', '1976-12-20 19:32:41', 'Sơn La ', 'Trưởng phòng', 'Bình Dương ', '91577', 'Ngân hàng Nam Á', 'Ninh Bình', 'Quảng Bình', '0509482968', '0788879010', 'xraxt8538@misa.com', 'Khánh Vân', '1975-07-16 02:21:37', 'Mộc Yến', '1993-10-17 10:13:52'),
('350cf027-3245-532d-bcd2-89b22d10517e', 'NV-2860', 'Lục Duy Huy', '1988-10-02 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '15958755', '1971-03-11 01:43:01', 'Quảng Trị ', 'Quản lý', 'Đồng Tháp ', '31505', 'Ngân hàng VPBank', 'Đà Nẵng ', 'Đồng Nai ', '0374762877', '0865829511', 'Almeida@gmail.com', 'An Thảo', '1991-07-25 20:03:56', 'Mộc Hà', '1986-11-23 23:04:51'),
('3512583a-64ab-33c0-6c80-7ed9d1ea06ea', 'NV-2710', 'Quảng Thị Ngọc', '1995-04-30 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '67512646', '1980-07-16 01:23:24', 'Quảng Nam ', 'Nhân viên cấp cao', 'Đắk Lắk ', '89685', 'Ngân hàng Quân đội', 'Lai Châu', 'Tây Ninh', '0970773592', '0988997325', 'wmwgzkbh.kfbsxx@gmail.com', 'Thị Nhung', '1991-09-10 04:07:48', 'Văn Tuấn', '2019-10-23 09:51:07'),
('3582e86f-1b41-6262-7ef6-423b4e874d0f', 'NV-4558', 'Vũ Duy Tùng', '1956-04-04 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '72844854', '1996-05-21 15:33:29', 'Bắc Kạn ', 'Nhân viên cấp cao', 'Quảng Bình', '75352', 'Ngân hàng Đông Á', 'Nghệ An', 'Bình Dương ', '0810609736', '0833576526', 'ckqbrfd1939@misa.com', 'Khánh Hiếu', '2018-07-31 03:01:42', 'Mỹ Ngọc', '1983-08-09 07:28:24'),
('35c3a053-254d-33f3-1b80-de64d090a2c2', 'NV-6195', 'Đoàn Văn Minh', '1953-06-15 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '11583923', '1970-01-01 00:14:57', 'Quảng Ngãi ', 'Trưởng phòng', 'Quảng Ngãi', '50419', 'Ngân hàng Nam Á', 'Đắk Lắk ', 'Nam Định', '0346202596', '0318189105', 'Loftis@misa.com', 'Thị Hằng', '1970-01-01 02:37:34', 'Khánh Nhung', '1970-01-01 00:14:52'),
('35ec2e7b-17b3-1b63-6080-7ed9d1ea06ea', 'NV-4178', 'Tán Ngọc Hằng', '1951-02-26 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '08246792', '1970-01-01 00:00:57', 'Phú Thọ ', 'Nhân viên', 'Bình Phước ', '98352', 'Ngân hàng Bản Việt', 'Đà Nẵng ', 'Lai Châu', '0712307988', '0952905559', 'HarrisonI2@misa.com', 'Văn Minh', '2011-07-11 06:45:28', 'Thị Yến', '2007-03-18 21:49:41'),
('360bd1e4-7bbf-3971-d41d-086412a8ea97', 'NV-0342', 'Tấn Ngọc Sơn', '1989-03-30 00:00:00', 1, '142cb08f-7c31-21fa-8e90-67245e8b283e', '61767584', '2002-05-02 00:26:28', 'Lào Cai ', 'Nhân viên', 'Quảng Ngãi', '57622', 'Ngân hàng PVcombank', 'Sóc Trăng', 'Bình Phước ', '0893496446', '0849854091', 'ClydeHuang843@misa.com', 'Thị Nhung', '2016-09-03 23:29:43', 'Thị Hằng', '1993-07-05 01:22:35'),
('363b67cb-40ae-552d-2b77-d9ebc53aac3d', 'NV-8411', 'Trần  Văn Tuấn', '1956-01-01 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '45753488', '1976-08-29 01:14:25', 'Kon Tum ', 'Nhân viên', 'Quảng Ninh', '37239', 'Ngân hàng VPBank', 'Quảng Ninh', 'Lai Châu', '0783400535', '0875188338', 'Cardenas@gmail.com', 'Thị Nga', '1979-06-08 03:27:29', NULL, '2002-04-16 18:40:57'),
('36ac2df8-2b1e-368f-cc1d-086412a8ea97', 'NV-8745', 'Sử Anh Nhung', '1971-09-29 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '84567808', '1990-04-24 17:09:38', 'Phú Yên ', 'Trưởng phòng', 'Phú Yên', '41347', 'Ngân hàng Đông Á', 'Quảng Bình', 'Bắc Kạn', '0869014366', '0332786473', 'Wolford931@gmail.com', 'Văn Hậu', '1970-01-01 00:04:54', 'Khánh Hạnh', '2006-12-01 13:04:03'),
('3738ce93-1661-5628-2cc2-579daad24557', 'NV-9227', 'Lý Thị Thảo', '1970-01-29 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '47108452', '1988-07-27 11:25:45', 'Quảng Trị ', 'Quản lý', 'Quảng Ninh', '70974', 'Ngân hàng Đông Nam Á', 'Ninh Bình', 'Đồng Tháp ', '0831812123', '0370455022', 'Anders@gmail.com', 'Văn Toản', '1984-11-11 20:04:20', 'Văn Toản', '2019-10-07 17:32:51'),
('373aae71-7e6b-6eff-c6d2-89b22d10517e', 'NV-8800', 'Võ Duy ', '1959-06-19 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '83586013', '1984-06-17 22:27:33', 'Bình Thuận  ', 'Quản lý', 'Đồng Tháp ', '28094', 'Ngân hàng Nam Á', 'Bạc Liêu ', 'Cà Mau ', '0558387594', '0851039812', 'Alton.Acker@gmail.com', 'Văn Quang', '1973-11-04 03:50:51', 'Văn Tùng', '2017-03-07 08:58:25'),
('38085202-6473-26a9-7bf6-423b4e874d0f', 'NV-5984', 'Lương Thị Yến', '1967-12-30 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '63727380', '1997-01-21 09:32:25', 'Bắc Ninh  ', 'Quản lý', 'Sơn La', '86337', 'Ngân hàng Kỹ Thương Việt Nam', 'Quảng Bình', 'Điện Biên ', '0368897996', '0992707326', 'AliGrayson@misa.com', 'Mỹ Yến', '1970-01-01 00:30:20', 'Ngọc Hiệp', '2006-12-04 23:34:32'),
('383760d5-6851-218b-4835-0028ed526dd0', 'NV-5713', 'Đặng Duy Toản', '1980-12-16 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '00021557', '2017-08-28 10:11:28', 'Quảng Bình ', 'Giám đốc', 'Lâm Đồng', '95186', 'Ngân hàng Nam Á', 'Phú Yên', 'Kon Tum', '0754076738', '0534317995', 'Golden_Jordan@gmail.com', 'Mỹ Vân', '1995-01-05 17:17:39', 'Văn Toản', '2016-08-22 22:01:04'),
('38dc720e-654a-29d5-34c2-579daad24557', 'NV-7709', 'Lục Mỹ Ngọc', '1974-10-23 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '04440164', '1992-01-27 11:38:51', 'Bạc Liêu  ', 'Trưởng phòng', 'Ninh Bình', '85094', 'Ngân hàng Bản Việt', 'Bắc Giang', 'Cao Bằng ', '0806236219', '0746348775', 'Klinger@gmail.com', 'Duy Tùng', '1970-01-01 00:00:03', 'Thị Giang', '1981-08-17 13:53:39'),
('395826c8-15a0-31f9-5980-7ed9d1ea06ea', 'NV-2887', 'Tạ Khánh ', '1989-12-03 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '46013655', '1980-02-09 14:09:09', 'Ninh Thuận ', 'Thực tập sinh', 'Điện Biên ', '94979', 'Ngân hàng Đông Á', 'Bình Dương ', 'Đà Nẵng ', '0978596359', '0397521171', 'Andreas.Armenta@misa.com', 'Văn Nhật', '2009-06-26 15:34:34', 'Mộc Huyền', '1982-01-02 02:09:37'),
('395fb299-3c5f-46fe-8841-c1ec321fe728', 'NV-1904', 'Hoàng Thị Hạnh', '1957-12-01 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '94839744', '1977-05-08 12:32:33', 'Điện Biên  ', 'Quản lý', 'Bà Rịa – Vũng Tàu', '18377', 'Ngân hàng VPBank', 'Quảng Nam', 'Kon Tum', '0326565865', '0353723743', 'Cosby@misa.com', 'Khánh Linh', '1970-01-01 00:08:22', 'Khánh Trang', '2009-01-02 20:30:52'),
('39f3c493-4680-145e-42c2-579daad24557', 'NV-2425', 'Trần  An Hằng', '1953-08-15 00:00:00', 2, '469b3ece-744a-45d5-957d-e8c757976496', '29084615', '1970-01-01 00:15:58', 'Phú Yên ', 'Phó phòng', 'Sóc Trăng', '24548', 'Ngân hàng PVcombank', 'Quảng Ngãi', 'Đồng Tháp ', '0817911506', '0381937465', 'Connors761@gmail.com', 'An Hằng', '1970-01-01 00:00:09', 'Thị Huyền', '1970-01-01 00:00:13'),
('3a425a4d-6066-116b-6bf6-423b4e874d0f', 'NV-4733', 'Đinh Anh Duy', '1951-07-11 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '82625925', '1993-06-27 20:46:13', 'Bình Định  ', 'Nhân viên', 'Đà Nẵng ', '23251', 'Ngân hàng Đông Á', 'Lạng Sơn', 'An Giang ', '0386480266', '0882307960', 'Browning422@gmail.com', 'An Sơn', '1970-01-01 00:01:09', 'Văn Toản', '1970-01-01 00:09:31'),
('3abffc51-2a43-18c6-6cf6-423b4e874d0f', 'NV-7782', 'Vũ Duy Quang', '1951-01-10 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '79920380', '1970-01-01 00:00:10', 'An Giang  ', 'Giám đốc', 'Điện Biên ', '33476', 'Ngân hàng An Bình', 'Cà Mau ', 'Phú Yên', '0954323892', '0798036540', 'Adelaida.Burkhart22@misa.com', 'Minh Luân', '2018-01-27 21:36:13', 'Khánh Hằng', '1970-01-01 00:00:01'),
('3ac85d96-49eb-7b1d-1135-60b3ebf808a9', 'NV-3458', 'Dương Duy Duy', '1953-03-15 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '42376064', '1970-01-01 00:13:25', 'Lâm Đồng ', 'Nhân viên cấp cao', 'Bình Thuận ', '70179', 'Ngân hàng Hàng Hải Việt Nam', 'Lai Châu', 'Lạng Sơn', '0892456464', '0834708831', 'JeanAcevedo35@misa.com', 'Duy Nam ', '2016-08-28 21:40:46', NULL, '2000-02-01 11:15:13'),
('3b668e3c-742f-4876-8e41-c1ec321fe728', 'NV-8849', 'Quách Văn Cương', '1954-07-09 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '15675147', '2014-04-26 02:54:30', 'Bà Rịa – Vũng Tàu ', 'Giám đốc', 'Cần Thơ ', '20879', 'Ngân hàng Kỹ Thương Việt Nam', 'Bình Phước ', 'Bình Phước ', '0935197162', '0570901683', 'Francisca_Smalley@gmail.com', 'Khánh Sơn', '1980-03-14 18:01:07', 'Minh Toản', '1970-01-01 00:01:20'),
('3b9be541-2ef2-4000-4bc2-579daad24557', 'NV-1504', 'Lý Khánh Toản', '1954-10-14 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '36787303', '1990-01-03 02:04:32', 'Nghệ An ', 'Phó phòng', 'Đồng Tháp ', '74372', 'Ngân hàng HDBank', 'Cần Thơ ', 'Bình Định ', '0917137679', '0575957123', 'LaverneJValentin8@misa.com', 'Văn Linh', '2021-05-07 20:33:02', 'Minh Toản', '1994-12-20 18:12:53'),
('3b9ddf67-2552-6683-5a80-7ed9d1ea06ea', 'NV-2435', 'Vũ An Hằng', '1974-11-25 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '84781007', '2000-11-27 06:35:59', 'Đồng Tháp  ', 'Thực tập sinh', 'Đắk Lắk ', '55739', 'Ngân hàng Nam Á', 'Sơn La', 'Bình Định ', '0962040586', '0710981036', 'TannerWakefield2@gmail.com', 'Duy ', '1984-08-23 11:19:44', 'Mộc Huyền', '2004-03-05 16:40:22'),
('3cb58bb5-2fd7-6c15-8741-c1ec321fe728', 'NV-7243', 'Lục Minh ', '2000-03-28 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '88630318', '1984-03-30 14:19:08', 'Phú Yên ', 'Phó phòng', 'Lâm Đồng', '18541', 'Ngân hàng HDBank', 'Kon Tum', 'Sóc Trăng', '0852666994', '0376279388', 'StellaParkinson25@gmail.com', 'Mỹ Hoa', '1971-09-23 16:14:09', 'Anh Hiền', '1990-10-10 17:22:25'),
('3cc7be2d-6406-4b95-3cc2-579daad24557', 'NV-7161', 'Ngô Ngọc Hương', '1965-01-05 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '81532820', '1983-06-25 03:03:26', 'Lâm Đồng ', 'Trưởng phòng', 'Tây Ninh', '43809', 'Ngân hàng Hàng Hải Việt Nam', 'Bình Định ', 'Nghệ An', '0738145609', '0832202732', 'Outlaw9@gmail.com', 'Duy Hiếu', '1991-03-10 19:13:39', 'Thị Hằng', '1970-01-01 00:00:04'),
('3d1266d8-49d7-3605-2477-d9ebc53aac3d', 'NV-1644', 'Võ Minh Hậu', '1987-06-26 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '73000238', '1971-03-05 01:04:54', 'Bà Rịa – Vũng Tàu ', 'Giám đốc', 'Lào Cai', '48566', 'Ngân hàng Á Châu', 'Điện Biên ', 'Bình Thuận ', '0899352991', '0569054449', 'Benton_Brackett2@misa.com', 'Anh Nga', '1991-07-23 06:48:19', 'Thị Thảo', '2011-05-20 01:34:41'),
('3d18d4c2-2f39-3dce-d61d-086412a8ea97', 'NV-2073', 'Sơn Thị Hiền', '1967-12-07 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '46547710', '1972-11-02 00:41:25', 'Cà Mau  ', 'Giám đốc', 'Ninh Thuận', '41885', 'Ngân hàng Quân đội', 'Bình Thuận ', 'Bình Thuận ', '0766005273', '0757097966', 'TommieJeter@misa.com', 'Mộc Thảo', '1991-04-13 17:35:13', 'Thị Huyền', '1992-09-22 02:55:04'),
('3d9b23c7-7369-2872-5635-0028ed526dd0', 'NV-5021', 'Dương Khánh Nhung', '1984-07-21 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '49614506', '1996-12-23 14:15:27', 'Sóc Trăng ', 'Nhân viên', 'Cao Bằng ', '68992', 'Ngân hàng Đông Á', 'Quảng Ninh', 'Bạc Liêu ', '0793542876', '0701795444', 'Gary_Mccreary@gmail.com', 'Ngọc Hằng', '1977-03-21 05:19:19', NULL, '1973-03-08 10:10:56'),
('3e2b2e81-5437-1a99-9441-c1ec321fe728', 'NV-8122', 'Tán Thị Nhung', '1962-05-12 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '76471590', '1998-03-16 23:12:25', 'Lào Cai ', 'Trưởng phòng', 'Ninh Bình', '45420', 'Ngân hàng Bản Việt', 'Đà Nẵng ', 'Sóc Trăng', '0962617413', '0334031129', 'KathyO_Kozlowski441@misa.com', 'Khánh Hương', '2019-10-01 14:47:30', 'Khánh Giang', '1970-01-01 00:01:22'),
('3e51a46c-4153-229c-7f41-c1ec321fe728', 'NV-5399', 'Sái An Toản', '1972-03-07 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '36092862', '2006-02-09 15:06:37', 'Phú Thọ ', 'Trưởng phòng', 'Lào Cai', '81506', 'Ngân hàng Phương Đông', 'Điện Biên ', 'An Giang ', '0547825377', '0793286483', 'Crabtree@gmail.com', 'Khánh Hạnh', '1970-01-01 00:09:09', NULL, '1993-01-13 13:42:21'),
('3e7dd0ec-7ee5-392a-1277-d9ebc53aac3d', 'NV-3052', 'Hồ Duy Linh', '1959-11-28 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '65749093', '1974-01-27 23:13:25', 'Bình Dương  ', 'Thực tập sinh', 'Bình Dương ', '91783', 'Ngân hàng HDBank', 'Đắk Nông ', 'Đồng Nai ', '0983415484', '0510845221', 'jeyvkfoj4702@gmail.com', 'Văn Nhật', '1970-01-01 02:04:26', 'Duy Đạt', '2011-12-18 18:26:12'),
('3f7028bf-3771-75c5-2380-de64d090a2c2', 'NV-2111', 'Dương Văn Toản', '1951-01-01 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '98219111', '1970-01-01 00:00:01', 'Quảng Bình ', 'Thực tập sinh', 'Kon Tum', '08804', 'Ngân hàng Phương Đông', 'Ninh Thuận', 'Đắk Nông ', '0982623850', '0838407334', 'Rocha@gmail.com', 'Thị Thu', '1970-01-01 00:00:07', 'Hải Huy', '2010-11-15 04:18:14'),
('3fa724dd-431f-5032-2a80-de64d090a2c2', 'NV-1516', 'Lương Mộc Giang', '1990-10-25 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '75846805', '1984-03-31 09:30:43', 'Tây Ninh ', 'Thực tập sinh', 'Lào Cai', '59845', 'Ngân hàng Á Châu', 'Bắc Giang', 'Bắc Ninh ', '0384835814', '0900825730', 'Bedard@gmail.com', 'Văn Hiệp', '1970-01-01 00:16:30', 'Văn Hậu', '1970-01-01 00:16:15'),
('3fc4ed08-1219-1c6d-5480-7ed9d1ea06ea', 'NV-2488', 'Sái Thị Hằng', '1999-02-16 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '65044219', '2015-10-12 16:39:52', 'Lâm Đồng ', 'Nhân viên cấp cao', 'Lào Cai', '48102', 'Ngân hàng Bản Việt', 'Quảng Ngãi', 'Bắc Ninh ', '0985844293', '0839312564', 'Allred@misa.com', 'Ngọc Thảo', '2004-10-27 19:00:34', 'Hải Tùng', '1970-01-01 02:08:04'),
('3fed64ec-2f94-798f-0335-60b3ebf808a9', 'NV-1305', 'Ngô Văn Dũng', '1967-04-16 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '03129425', '1978-04-20 09:52:40', 'Cà Mau  ', 'Thực tập sinh', 'Bến Tre ', '04117', 'Ngân hàng Nam Á', 'Tây Ninh', 'Lạng Sơn', '0509896018', '0530773455', 'CoreenAcker@misa.com', 'Thị Anh', '2003-11-18 21:41:29', 'Ngọc Trang', '1999-12-27 21:33:46'),
('40160288-72cf-185c-c8d2-89b22d10517e', 'NV-5171', 'Tăng Ngọc Nhung', '1967-02-15 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '25198224', '1970-01-01 01:38:10', 'Bắc Kạn ', 'Thực tập sinh', 'Đồng Nai ', '50192', 'Ngân hàng Nam Á', 'Sơn La', 'Đồng Tháp ', '0311531993', '0800789785', 'MylesHendrick728@misa.com', 'Duy ', '1970-01-01 02:33:48', 'Khánh Huyền', '1982-12-07 21:35:41'),
('401e72cc-49b0-5b4a-5335-0028ed526dd0', 'NV-0625', 'Vũ Thị Hương', '1971-05-25 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '43210159', '1974-08-19 19:34:15', 'Quảng Bình ', 'Giám đốc', 'Quảng Ninh', '56762', 'Ngân hàng Phương Đông', 'Đắk Nông ', 'Quảng Ngãi', '0330415882', '0743085385', 'Bowens@gmail.com', 'Khánh Toản', '1990-01-28 04:47:05', 'Mỹ Thảo', '1970-01-01 00:58:15'),
('4029deb6-568c-284f-8941-c1ec321fe728', 'NV-4802', 'Lý Thị Hương', '1998-01-26 00:00:00', 2, '469b3ece-744a-45d5-957d-e8c757976496', '92790829', '1977-06-04 02:38:10', 'Kon Tum ', 'Nhân viên', 'Đồng Tháp ', '72635', 'Ngân hàng Hàng Hải Việt Nam', 'Đồng Nai ', 'Nghệ An', '0754834112', '0322163423', 'Kang@gmail.com', 'Duy Huy', '2007-10-13 08:30:06', 'Duy Cường', '1982-06-10 21:03:33'),
('405d596c-21be-7e1a-3dc2-579daad24557', 'NV-0866', 'Sái Duy Tuấn', '1960-08-01 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '07901045', '1970-01-01 00:58:21', 'Bắc Ninh  ', 'Quản lý', 'Quảng Ninh', '70337', 'Ngân hàng Nam Á', 'Bình Thuận ', 'Đồng Tháp ', '0598295821', '0852166351', 'AlexandriaNolan@gmail.com', 'Minh Hiệp', '2003-06-11 02:12:33', 'Ngọc Thảo', '2011-12-20 05:25:06'),
('407db4d1-222b-287d-0135-60b3ebf808a9', 'NV-9368', 'Quách Minh Luân', '1983-06-14 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '64540813', '2006-09-01 10:10:04', 'Cần Thơ  ', 'Nhân viên', 'Sơn La', '07653', 'Ngân hàng Kỹ Thương Việt Nam', 'Lào Cai', 'Quảng Ninh', '0764994314', '0787890395', 'Haynes@misa.com', 'Khánh Toản', '2007-02-23 03:38:48', 'Duy Tuấn', '1985-02-02 12:05:24'),
('40904e10-3084-1af7-2a77-d9ebc53aac3d', 'NV-9652', 'Huỳnh Khánh Anh', '1951-03-23 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '50806814', '1970-01-01 00:01:22', 'Cao Bằng  ', 'Nhân viên cấp cao', 'Bình Định ', '38554', 'Ngân hàng Quân đội', 'Đắk Lắk ', 'Sóc Trăng', '0735121669', '0928017284', 'Kelso@misa.com', 'Văn Tùng', '2021-06-23 12:28:18', 'Văn Đạt', '1976-08-14 12:28:54'),
('409dcd1a-426a-23f7-3a35-0028ed526dd0', 'NV-6091', 'Quang Văn Lâm ', '1981-02-22 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '59327864', '1971-08-28 21:40:14', 'Cà Mau  ', 'Nhân viên', 'Bình Dương ', '87627', 'Ngân hàng Đông Nam Á', 'Đồng Tháp ', 'Đắk Lắk ', '0861525522', '0945406743', 'Teresia_Avalos@misa.com', 'Khánh Hằng', '1971-05-15 02:23:39', 'Thị Yến', '2009-04-04 13:22:54'),
('40fff47f-4425-60cb-5135-0028ed526dd0', 'NV-5419', 'Đặng Khánh Bảo ', '1982-03-11 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '19450064', '2019-01-27 17:01:27', 'An Giang  ', 'Trưởng phòng', 'Cao Bằng ', '80072', 'Ngân hàng Nam Á', 'An Giang ', 'Bình Phước ', '0881597975', '0388033539', 'Rema_Vanwinkle@gmail.com', 'Văn Dũng', '2018-07-19 02:11:02', 'Ngọc Toản', '1987-09-25 03:08:38'),
('417f31fa-5c7b-6b08-6280-7ed9d1ea06ea', 'NV-0227', 'Sử Thị Hằng', '2000-10-01 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '30193278', '1986-12-04 09:31:32', 'Bến Tre  ', 'Nhân viên cấp cao', 'Quảng Trị', '39469', 'Ngân hàng Hàng Hải Việt Nam', 'Phú Yên', 'Phú Yên', '0962580809', '0339240534', 'KeturahBower@gmail.com', 'Ngọc Duy', '1975-11-17 23:16:08', 'Khánh ', '2004-01-22 22:33:46'),
('41f1acba-3177-4b1c-c4d2-89b22d10517e', 'NV-9633', 'Võ Khánh Tuấn', '1994-05-14 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '33183939', '2013-11-17 01:24:20', 'Sóc Trăng ', 'Phó phòng', 'Lâm Đồng', '38572', 'Ngân hàng Kỹ Thương Việt Nam', 'Quảng Ngãi', 'Cần Thơ ', '0549674807', '0584694534', 'JoeRead@misa.com', 'Mỹ Yến', '1970-01-01 00:14:09', 'Văn Linh', '1970-01-01 00:01:23'),
('42a13e31-2abb-6171-dc1d-086412a8ea97', 'NV-2935', 'Tạ Mộc Ngọc', '1956-04-12 00:00:00', 1, '142cb08f-7c31-21fa-8e90-67245e8b283e', '69862732', '2014-02-26 18:36:22', 'Phú Thọ ', 'Thực tập sinh', 'An Giang ', '57354', 'Ngân hàng Phương Đông', 'Đồng Tháp ', 'Ninh Thuận', '0757993739', '0934391989', 'Abney9@gmail.com', 'Ngọc Hậu', '1970-01-01 00:00:32', 'Văn Trung', '1981-01-28 01:31:04'),
('42b9446a-790b-3892-2ac2-579daad24557', 'NV-2142', 'Nguyễn Mộc Linh', '1963-02-27 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '73292852', '1971-02-13 02:24:00', 'Quảng Nam ', 'Giám đốc', 'Quảng Trị', '76640', 'Ngân hàng Kỹ Thương Việt Nam', 'Quảng Ngãi', 'Cà Mau ', '0351764570', '0906446366', 'Wise938@gmail.com', 'Duy Nguyên', '2016-05-17 10:46:21', 'Văn Quang', '1970-01-01 00:08:45'),
('42db9027-5e76-257b-33c2-579daad24557', 'NV-2464', 'Hoàng Ngọc Anh', '1963-04-29 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '10894694', '1994-06-05 15:26:19', 'Lào Cai ', 'Nhân viên', 'Bạc Liêu ', '61507', 'Ngân hàng Tiên Phong', 'Phú Thọ', 'Quảng Bình', '0307925178', '0802555113', 'Dani.Massie@gmail.com', 'Văn Toản', '1979-02-14 11:36:44', 'Thị Giang', '1988-12-19 06:53:24'),
('434d4eb6-140c-38b4-4cc2-579daad24557', 'NV-9259', 'Sái An Toản', '1998-09-01 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '49234558', '1989-02-21 20:59:02', 'Bà Rịa – Vũng Tàu ', 'Phó phòng', 'Quảng Nam', '08034', 'Ngân hàng VPBank', 'Lào Cai', 'Bắc Ninh ', '0792168105', '0739696351', 'Latham112@gmail.com', 'Khánh Tuấn', '1996-04-15 03:21:04', 'Khánh Nhung', '1970-01-01 00:00:37'),
('443674f7-78a9-5ffa-4f35-0028ed526dd0', 'NV-9569', 'Quán An Toản', '1961-02-14 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '98905444', '2018-12-11 13:57:03', 'Nghệ An ', 'Nhân viên', 'Đắk Lắk ', '61227', 'Ngân hàng Phương Đông', 'Cần Thơ ', 'Cao Bằng ', '0931055639', '0720028528', 'Harwood@misa.com', 'Duy Hiệp', '1970-01-01 00:01:07', 'Văn Huy', '1987-03-25 04:19:11'),
('45ae58dc-49a1-14b9-3180-de64d090a2c2', 'NV-0890', 'Đinh Mỹ Nhung', '1951-01-01 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '94346890', '1970-01-01 00:00:01', 'Bình Thuận  ', 'Nhân viên cấp cao', 'Cần Thơ ', '22584', 'Ngân hàng Bản Việt', 'Bắc Ninh ', 'Lai Châu', '0912805548', '0311650858', 'ChariseChavez5@gmail.com', 'Mỹ Anh', '1984-01-30 16:57:04', 'Mỹ Thảo', '1984-01-15 11:51:50'),
('45bd4aa1-3832-3db8-d21d-086412a8ea97', 'NV-5564', 'Vũ Thị Thảo', '1988-07-28 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '68894253', '1981-04-03 00:20:38', 'Phú Yên ', 'Giám đốc', 'Bắc Giang', '39967', 'Ngân hàng Kỹ Thương Việt Nam', 'Cần Thơ ', 'Bạc Liêu ', '0377596291', '0749164622', 'Pak@gmail.com', 'Mỹ Hiền', '1986-06-27 21:14:26', 'Duy Linh', '1991-01-22 01:33:19'),
('45c09477-664f-1904-0f35-60b3ebf808a9', 'NV-3850', 'Mai Văn Tùng', '1958-12-07 00:00:00', 2, '469b3ece-744a-45d5-957d-e8c757976496', '99906287', '2017-01-05 14:44:31', 'Sơn La ', 'Giám đốc', 'Lạng Sơn', '96789', 'Ngân hàng HDBank', 'Đồng Nai ', 'Quảng Trị', '0787770602', '0988681273', 'Nieves@gmail.com', 'Mỹ Nhung', '1970-01-01 00:14:11', 'Văn Nhật', '1985-03-21 04:00:02'),
('46325c89-599d-77ef-74f6-423b4e874d0f', 'NV-7497', 'Phạm Mộc Thu', '1988-02-16 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '39122054', '2015-09-22 10:35:41', 'Cần Thơ  ', 'Trưởng phòng', 'Bắc Giang', '89082', 'Ngân hàng Bắc Á', 'Nam Định', 'Lạng Sơn', '0856506164', '0857621891', 'VaughtI136@misa.com', 'Duy Huy', '1970-01-01 01:24:55', 'Ngọc Tùng', '1971-04-14 10:15:45'),
('46421cb1-7414-1d61-2c80-de64d090a2c2', 'NV-0233', 'Lê Văn Lộc ', '1951-03-26 00:00:00', 1, '142cb08f-7c31-21fa-8e90-67245e8b283e', '09648483', '1970-01-01 00:01:25', 'Cao Bằng  ', 'Trưởng phòng', 'Điện Biên ', '64054', 'Ngân hàng Kỹ Thương Việt Nam', 'Bắc Kạn', 'Đà Nẵng ', '0593385120', '0998737602', 'AdamHaywood276@gmail.com', 'Thị Hiền', '1973-12-30 10:16:49', 'Thị Hằng', '1970-01-01 01:30:57'),
('481183cb-5a6c-795b-68f6-423b4e874d0f', 'NV-5215', 'Quán Mỹ Ngọc', '1990-03-18 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '30845326', '1992-02-27 22:06:16', 'Cà Mau  ', 'Trưởng phòng', 'Đồng Tháp ', '99710', 'Ngân hàng Đông Á', 'Sơn La', 'Bà Rịa – Vũng Tàu', '0716252747', '0752510793', 'Canada@misa.com', 'Văn Lâm ', '2013-05-04 13:49:40', 'Duy Tùng', '1993-10-18 12:41:09'),
('48147636-7e8f-6939-2580-de64d090a2c2', 'NV-9154', 'Nguyễn Khánh Yến', '1988-09-29 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '14342019', '2000-08-15 22:23:07', 'Ninh Thuận ', 'Phó phòng', 'Sơn La', '90178', 'Ngân hàng Đông Á', 'Quảng Bình', 'An Giang ', '0732703982', '0311800717', 'Jose_Lawrence6@gmail.com', 'Thị Hà', '1972-05-13 08:38:34', 'Anh Giang', '2013-12-19 12:51:21'),
('4852769b-3986-7c69-2077-d9ebc53aac3d', 'NV-6418', 'Hoàng Duy Tuấn', '1999-08-15 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '05797572', '1988-06-27 08:22:25', 'Bắc Ninh  ', 'Thực tập sinh', 'Cao Bằng ', '69646', 'Ngân hàng Đông Á', 'Lâm Đồng', 'An Giang ', '0758074144', '0809570261', 'uoyix131@gmail.com', 'Anh Anh', '1988-10-29 03:25:09', 'Duy Cường', '1972-11-12 21:10:06'),
('4863fe5f-13df-4653-9041-c1ec321fe728', 'NV-2386', 'Đinh Thị Nhung', '1996-02-13 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '47135285', '1994-11-10 17:30:56', 'Nam Định ', 'Quản lý', 'Phú Thọ', '00556', 'Ngân hàng Phương Đông', 'Bà Rịa – Vũng Tàu', 'Quảng Ninh', '0352058632', '0804445779', 'Robbie.Autry@gmail.com', 'Thị Nhung', '2021-01-16 09:11:09', NULL, '1997-01-27 19:43:36'),
('4989ff24-23e7-7b82-b6d2-89b22d10517e', 'NV-1766', 'Vũ Thị Yến', '1964-11-20 00:00:00', 1, '142cb08f-7c31-21fa-8e90-67245e8b283e', '10569302', '2017-04-02 21:15:17', 'Lạng Sơn ', 'Phó phòng', 'Cao Bằng ', '63258', 'Ngân hàng An Bình', 'Bắc Ninh ', 'Phú Thọ', '0731329518', '0569799153', 'Adah_N_Wofford@gmail.com', 'Văn Nam ', '2018-05-25 02:31:44', 'Duy Toản', '1970-01-01 00:00:02'),
('4a594072-7a23-18da-c9d2-89b22d10517e', 'NV-9802', 'Nguyễn Khánh Tuấn', '1953-03-15 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '53743107', '1970-01-01 00:13:25', 'Nghệ An ', 'Trưởng phòng', 'Bình Định ', '28465', 'Ngân hàng Bản Việt', 'Điện Biên ', 'Bến Tre ', '0583528972', '0531207536', 'AlvaPedersen532@misa.com', 'Duy Sơn', '1994-12-19 12:46:44', 'Duy Luân', '1970-01-01 00:00:06'),
('4a9854e8-12ac-72ac-2877-d9ebc53aac3d', 'NV-3848', 'Quách Khánh Toản', '1987-03-27 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '83655253', '1989-05-10 16:42:29', 'Bắc Ninh  ', 'Giám đốc', 'Nghệ An', '03446', 'Ngân hàng Quân đội', 'Quảng Ninh', 'Đắk Nông ', '0314352667', '0844241633', 'TerryBueno947@misa.com', 'Anh Hiền', '1970-01-01 00:00:07', 'Thị Vân', '2016-06-26 23:54:11'),
('4b649055-43d5-2b07-de1d-086412a8ea97', 'NV-0103', 'Đặng Thị Giang', '1993-10-13 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '12708380', '2011-03-02 22:37:53', 'Quảng Trị ', 'Nhân viên cấp cao', 'Lai Châu', '14149', 'Ngân hàng Kỹ Thương Việt Nam', 'Đắk Nông ', 'Điện Biên ', '0386543095', '0818014661', 'AikoMartz@misa.com', 'Mỹ Nhung', '1970-01-01 00:16:31', 'Khánh Yến', '2020-11-30 21:43:21'),
('4bf4567b-1505-40db-dd1d-086412a8ea97', 'NV-2191', 'Tề Khánh Thảo', '1984-10-06 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '92747600', '2004-10-01 21:43:48', 'Bình Thuận  ', 'Trưởng phòng', 'Kon Tum', '62165', 'Ngân hàng HDBank', 'Nghệ An', 'Sơn La', '0705535809', '0349963455', 'Naranjo356@gmail.com', 'Văn Nguyên', '2009-04-11 17:01:06', 'Văn Cương', '1983-05-15 07:34:40'),
('4bf9ecda-2d8e-1724-1d80-de64d090a2c2', 'NV-5662', 'Quảng Khánh Thảo', '1999-05-07 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '28209125', '1981-05-24 22:53:45', 'Đà Nẵng  ', 'Thực tập sinh', 'Đồng Nai ', '10611', 'Ngân hàng Kỹ Thương Việt Nam', 'Đắk Nông ', 'Lào Cai', '0818560101', '0937515216', 'AdamPullen@gmail.com', 'Khánh Thảo', '2004-04-22 09:52:21', 'Thị Yến', '1970-01-01 00:01:40'),
('4c14bdf4-3327-39eb-2d80-de64d090a2c2', 'NV-2963', 'Quang Duy Tuấn', '1965-09-02 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '16334055', '1995-02-02 16:17:57', 'Nghệ An ', 'Nhân viên', 'Tây Ninh', '05927', 'Ngân hàng HDBank', 'Ninh Bình', 'Sơn La', '0543918673', '0828399875', 'Raymundo.Sturm@misa.com', 'Thị Phương', '1970-01-01 00:00:05', 'Ngọc Thảo', '1970-01-01 00:01:37'),
('4c61c74b-4a9f-769e-0d35-60b3ebf808a9', 'NV-4815', 'Dương An Anh', '1951-01-04 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '17038048', '1970-01-01 00:00:04', 'Bạc Liêu  ', 'Trưởng phòng', 'Bà Rịa – Vũng Tàu', '26164', 'Ngân hàng Phương Đông', 'Cao Bằng ', 'Cà Mau ', '0942030986', '0305423826', 'Corcoran@gmail.com', 'Văn Toản', '2017-08-28 19:05:43', 'Thị Phương', '1995-10-14 02:59:59'),
('4c9ebdde-5f9a-58dd-4235-0028ed526dd0', 'NV-7484', 'Lương Thị Phương', '1951-01-02 00:00:00', 2, '469b3ece-744a-45d5-957d-e8c757976496', '40248437', '1970-01-01 00:00:02', 'Bạc Liêu  ', 'Thực tập sinh', 'Cần Thơ ', '22850', 'Ngân hàng PVcombank', 'Cao Bằng ', 'Phú Thọ', '0903864620', '0842557194', 'CarolPCoronado@misa.com', 'Mộc Thảo', '2011-09-22 00:24:31', 'Văn Toản', '1970-01-01 00:15:28'),
('4cc606bb-3068-7d32-3f35-0028ed526dd0', 'NV-0249', 'Sơn Duy Toản', '1997-08-05 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '02492606', '2009-04-01 00:07:42', 'Nam Định ', 'Nhân viên', 'Kon Tum', '72254', 'Ngân hàng Đông Nam Á', 'Bình Thuận ', 'Nghệ An', '0390339617', '0592671590', 'LaurieOsullivan@gmail.com', 'Thị Hằng', '1970-01-01 00:01:24', 'Văn Nhật', '2006-05-14 09:03:10'),
('4d536cce-31bf-335e-bfd2-89b22d10517e', 'NV-0818', 'Quán Duy Linh', '1991-07-09 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '97383339', '1972-12-17 13:48:50', 'Kon Tum ', 'Nhân viên cấp cao', 'Quảng Trị', '29165', 'Ngân hàng PVcombank', 'Bình Định ', 'Bến Tre ', '0977512382', '0566412886', 'Mickey_South@gmail.com', 'Anh Tùng', '2009-11-05 13:38:23', 'Duy ', '1970-05-11 20:37:53'),
('4d6d3d5c-26da-45b3-2977-d9ebc53aac3d', 'NV-8398', 'Nguyễn Duy Nguyên', '1989-09-01 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '98672619', '1996-05-17 20:54:47', 'Phú Thọ ', 'Trưởng phòng', 'Ninh Thuận', '01638', 'Ngân hàng Tiên Phong', 'Nghệ An', 'Bà Rịa – Vũng Tàu', '0872280264', '0981560120', 'Jasmine_Albert@gmail.com', 'Thị Vân', '1980-11-16 05:56:58', 'Văn Toản', '1990-07-16 11:00:05'),
('4db9a514-6d87-2ec1-3b35-0028ed526dd0', 'NV-0812', 'Phạm Thị Hằng', '1980-08-21 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '26043096', '2013-09-24 11:02:47', 'Quảng Ninh ', 'Phó phòng', 'Nam Định', '72355', 'Ngân hàng An Bình', 'Nghệ An', 'Đà Nẵng ', '0828568215', '0341777182', 'LissaKrebs@gmail.com', 'Mộc Yến', '1971-07-17 08:58:31', 'Văn Nhật', '1993-12-30 01:55:35'),
('4dd0746a-6f49-64fa-1d77-d9ebc53aac3d', 'NV-9624', 'Mai Anh Sơn', '1951-11-23 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '91197496', '1970-01-01 00:05:27', 'Ninh Bình ', 'Quản lý', 'Bắc Kạn', '46034', 'Ngân hàng Quân đội', 'Nghệ An', 'Đắk Nông ', '0862292126', '0395408987', 'AdelaK_Clawson322@gmail.com', 'Thị Anh', '1970-01-01 00:33:05', 'Thị Anh', '1970-01-01 00:00:05'),
('4e2c885d-5347-35dc-79f6-423b4e874d0f', 'NV-9681', 'Quang Ngọc Anh', '1951-03-21 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '03627154', '1995-12-18 09:51:28', 'Bắc Giang ', 'Quản lý', 'Tây Ninh', '27277', 'Ngân hàng VPBank', 'Ninh Bình', 'Bình Định ', '0763189353', '0369266936', 'OmegaHales@misa.com', 'An Phương', '1998-04-25 16:50:55', NULL, '2021-06-07 05:41:16'),
('4eb131b8-234a-632f-4b35-0028ed526dd0', 'NV-4213', 'Lý Duy Nam ', '1951-01-27 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '85724157', '1970-01-01 00:00:27', 'Cao Bằng  ', 'Nhân viên cấp cao', 'Đắk Lắk ', '89894', 'Ngân hàng Tiên Phong', 'Quảng Trị', 'Bắc Ninh ', '0858226439', '0938123223', 'Noonan@gmail.com', 'Văn Minh', '1994-03-27 07:46:54', 'Văn Toản', '2011-11-27 00:43:38'),
('4efc95ad-2cc2-3f45-bed2-89b22d10517e', 'NV-2642', 'Hồ Thị Hằng', '1990-09-15 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '73922012', '1983-03-03 18:09:48', 'Ninh Thuận ', 'Phó phòng', 'Đắk Nông ', '03310', 'Ngân hàng Bản Việt', 'Phú Yên', 'Quảng Ninh', '0985751861', '0716817849', 'Valentine_Berry96@gmail.com', 'Khánh Hằng', '1990-12-27 01:15:52', 'Minh Minh', '2010-06-16 02:50:39'),
('4f65f6c1-4525-16e5-4135-0028ed526dd0', 'NV-7375', 'Tào Thị Nhung', '1988-11-10 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '27239426', '1973-02-18 07:03:46', 'Bình Dương  ', 'Nhân viên cấp cao', 'Sóc Trăng', '55569', 'Ngân hàng Đông Nam Á', 'Quảng Bình', 'Điện Biên ', '0563145019', '0719749656', 'Connors@gmail.com', 'Mộc Ngọc', '1973-01-20 23:59:59', 'Văn Tuấn', '2017-03-14 07:37:14'),
('4f6e3234-1da4-7273-c7d2-89b22d10517e', 'NV-6103', 'Quảng Khánh Toản', '1996-03-11 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '62641749', '1991-12-14 20:28:37', 'Lai Châu ', 'Giám đốc', 'Lâm Đồng', '28966', 'Ngân hàng Đông Á', 'Phú Yên', 'Nam Định', '0541761566', '0761468083', 'Bumgarner632@misa.com', 'Văn Linh', '1970-01-01 00:00:09', 'An Tuấn', '1985-04-01 00:53:16'),
('500b6761-1631-4f3a-c0d2-89b22d10517e', 'NV-0179', 'Tấn Duy Minh', '1951-02-17 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '93085190', '1970-01-01 00:00:48', 'Sóc Trăng ', 'Trưởng phòng', 'Nghệ An', '07681', 'Ngân hàng Á Châu', 'Lạng Sơn', 'Bắc Giang', '0348435150', '0713059486', 'CesarAhrens@gmail.com', 'Thị Linh', '2003-01-01 23:03:30', 'Văn Trung', '1988-06-07 03:33:47'),
('50253399-32d6-3154-5535-0028ed526dd0', 'NV-8369', 'Vũ Mộc Anh', '1984-07-26 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '09575644', '2006-10-24 03:04:33', 'Phú Yên ', 'Phó phòng', 'Bình Thuận ', '58359', 'Ngân hàng Á Châu', 'Bắc Ninh ', 'Bình Phước ', '0796820299', '0885518901', 'Ali_Burr@gmail.com', 'Ngọc Thảo', '1994-06-01 05:42:54', 'An Nhật', '1970-01-01 00:15:07'),
('506acf1e-5331-67a9-0d77-d9ebc53aac3d', 'NV-8739', 'Sử Văn Đạt', '1964-01-15 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '67903019', '1970-01-01 01:19:23', 'Lạng Sơn ', 'Quản lý', 'Lạng Sơn', '57474', 'Ngân hàng HDBank', 'Cần Thơ ', 'Đồng Nai ', '0872672420', '0779392759', 'KearneyG616@gmail.com', 'Ngọc Toản', '2012-04-15 06:14:35', 'Thị Yến', '1970-01-01 00:00:09'),
('50b49b1f-3df8-4b52-db1d-086412a8ea97', 'NV-1589', 'Phan Văn Toản', '1987-02-03 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '24933954', '2015-04-25 20:41:25', 'Lào Cai ', 'Phó phòng', 'An Giang ', '45529', 'Ngân hàng Á Châu', 'Bình Phước ', 'Bình Phước ', '0913654206', '0785957026', 'Abel_Simons843@gmail.com', 'Khánh Anh', '2020-07-12 04:52:16', 'Văn Hậu', '1999-11-15 09:01:25'),
('50c07587-55d5-5b36-1b77-d9ebc53aac3d', 'NV-0156', 'Sử Anh Nhung', '1962-11-06 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '83141131', '2003-11-07 16:55:43', 'Bắc Ninh  ', 'Phó phòng', 'Bắc Giang', '60553', 'Ngân hàng Bắc Á', 'Ninh Bình', 'Bắc Kạn', '0868145705', '0395433228', 'SanaLilley759@gmail.com', 'Ngọc Hằng', '1973-09-15 19:40:32', 'Khánh Lâm ', '1970-01-01 00:06:57'),
('5163ba6d-4e5a-4043-df1d-086412a8ea97', 'NV-4827', 'Phan Khánh Giang', '1955-02-02 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '83191092', '2016-08-20 11:34:23', 'Bình Thuận  ', 'Thực tập sinh', 'Đà Nẵng ', '86265', 'Ngân hàng Tiên Phong', 'Quảng Nam', 'Ninh Bình', '0770310071', '0801983877', 'VondaZGraham@gmail.com', 'Văn Hiếu', '1998-10-14 01:01:11', 'Văn Bảo ', '2012-01-16 17:00:35'),
('517035f8-43a9-4c59-72f6-423b4e874d0f', 'NV-7616', 'Lục Mỹ Linh', '1978-05-20 00:00:00', 1, '142cb08f-7c31-21fa-8e90-67245e8b283e', '94690759', '1978-10-23 00:16:39', 'Kon Tum ', 'Phó phòng', 'Lào Cai', '30875', 'Ngân hàng PVcombank', 'Quảng Ngãi', 'Bình Dương ', '0728362052', '0319505366', 'Grover923@gmail.com', 'Thị Thảo', '1983-12-02 09:08:34', 'Khánh Sơn', '1970-01-01 00:00:36'),
('51b5ac10-6dea-17ad-2080-de64d090a2c2', 'NV-5458', 'Quàng Thị Nhung', '1997-11-09 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '56065879', '1984-01-03 07:10:33', 'Đắk Lắk  ', 'Nhân viên cấp cao', 'Nghệ An', '96897', 'Ngân hàng Tiên Phong', 'Sóc Trăng', 'Nam Định', '0995694839', '0359411196', 'DeannAviles91@gmail.com', 'Duy Lộc ', '2007-03-20 13:10:13', 'Văn Nam ', '1970-01-01 00:00:01'),
('51c6e7d3-53bf-49ae-8a41-c1ec321fe728', 'NV-8944', 'Sầm Anh Nhung', '1981-01-04 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '28655021', '1979-05-06 23:31:15', 'Kon Tum ', 'Quản lý', 'Quảng Ninh', '85464', 'Ngân hàng Bắc Á', 'Đà Nẵng ', 'Đắk Lắk ', '0573598135', '0535650861', 'Pressley@gmail.com', 'Mộc Trang', '1970-01-01 01:38:35', 'Khánh Phương', '2010-10-19 14:18:00'),
('524751f2-1577-523d-ce1d-086412a8ea97', 'NV-9603', 'Tăng Khánh Nam ', '1990-10-04 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '79666073', '2018-04-05 04:39:48', 'Quảng Bình ', 'Trưởng phòng', 'Quảng Ninh', '66085', 'Ngân hàng Quân đội', 'Nam Định', 'Lai Châu', '0755405910', '0352853422', 'Crittenden@gmail.com', 'Văn Toản', '1978-01-30 14:19:51', 'Văn Đạt', '1991-08-09 18:52:54'),
('5254e49d-4368-3162-29c2-579daad24557', 'NV-8798', 'Lê Văn Toản', '1978-11-02 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '94024275', '2011-12-12 18:05:38', 'Sơn La ', 'Quản lý', 'Bắc Kạn', '50103', 'Ngân hàng Bắc Á', 'Bắc Kạn', 'Bắc Giang', '0764538757', '0928628525', 'Ewing@gmail.com', 'An Tùng', '2011-08-02 06:55:12', 'Mộc Hạnh', '1970-01-01 00:00:02'),
('527e293c-2185-6d0a-5580-7ed9d1ea06ea', 'NV-3227', 'Tào Mộc Trang', '1993-03-23 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '78463324', '2004-02-04 15:07:40', 'Bà Rịa – Vũng Tàu ', 'Thực tập sinh', 'Đắk Nông ', '08488', 'Ngân hàng Á Châu', 'Bình Dương ', 'Cà Mau ', '0313570345', '0760326404', 'Cletus_Gibbons46@misa.com', 'Mộc Mai', '1970-01-01 00:00:03', 'Mộc Ngọc', '1983-10-01 09:51:31'),
('52a36f9d-42d4-6841-38c2-579daad24557', 'NV-7389', 'Đỗ An Dũng', '1987-04-06 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '19877994', '2021-07-12 18:25:15', 'Bắc Ninh  ', 'Nhân viên cấp cao', 'Phú Thọ', '80925', 'Ngân hàng Á Châu', 'Quảng Trị', 'Bắc Giang', '0960004429', '0728572415', 'Abel@gmail.com', 'Thị Hoa', '2020-09-06 07:54:20', NULL, '1993-12-01 14:14:43'),
('535ddd98-1493-7909-1e80-de64d090a2c2', 'NV-3074', 'Tấn Văn Toản', '1998-08-31 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '13561547', '2002-08-07 01:20:47', 'Phú Thọ ', 'Trưởng phòng', 'Nam Định', '64069', 'Ngân hàng Hàng Hải Việt Nam', 'Lâm Đồng', 'Lạng Sơn', '0542444622', '0973700773', 'MerleEdmonds@misa.com', 'Khánh Sơn', '2018-01-23 07:29:11', 'Thị Yến', '1983-01-31 06:14:58'),
('53f68d51-267f-2d1e-8241-c1ec321fe728', 'NV-4847', 'Dương Hải Luân', '1975-03-29 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '51321233', '2008-03-24 02:04:28', 'Bắc Giang ', 'Thực tập sinh', 'Quảng Nam', '94265', 'Ngân hàng Hàng Hải Việt Nam', 'Quảng Trị', 'Quảng Bình', '0310162175', '0736882941', 'ouyv2840@misa.com', 'An Hoa', '1970-01-01 00:15:57', 'Mộc Giang', '1981-04-27 19:28:50'),
('5440d89a-638d-5382-47c2-579daad24557', 'NV-9179', 'Tăng Khánh Hậu', '1960-10-29 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '45735028', '1980-06-10 04:56:23', 'Lâm Đồng ', 'Quản lý', 'Quảng Trị', '80912', 'Ngân hàng Nam Á', 'Cao Bằng ', 'Bắc Ninh ', '0884622993', '0385302443', 'NorbertO.Bedford443@gmail.com', 'Khánh Hà', '2001-12-21 02:46:50', 'Mỹ Vân', '1970-01-01 00:01:04'),
('56249d42-1aee-20b3-3fc2-579daad24557', 'NV-8128', 'Tề Văn Toản', '1974-05-15 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '50967632', '2019-09-19 22:16:07', 'Phú Yên ', 'Nhân viên cấp cao', 'Ninh Thuận', '68271', 'Ngân hàng Tiên Phong', 'Cà Mau ', 'Điện Biên ', '0595171512', '0309450064', 'IngleA316@gmail.com', 'Khánh Hiệp', '1970-08-04 13:54:16', 'Thị Yến', '1996-11-27 03:26:08'),
('56313fc9-7b84-1517-3080-de64d090a2c2', 'NV-8084', 'Sử Văn Toản', '1991-12-12 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '87355104', '2011-09-06 02:13:13', 'Quảng Ngãi ', 'Quản lý', 'Lào Cai', '82582', 'Ngân hàng VPBank', 'Ninh Thuận', 'Đắk Nông ', '0995104095', '0322023429', 'NoeF.Osburn@gmail.com', 'Thị Hiền', '1996-09-22 16:32:26', 'Anh Cường', '1991-07-24 08:58:58'),
('564127b8-58f3-46f3-7df6-423b4e874d0f', 'NV-0752', 'Quàng Ngọc Thảo', '1955-12-11 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '14557075', '1988-05-15 06:56:43', 'Đà Nẵng  ', 'Thực tập sinh', 'Bạc Liêu ', '51460', 'Ngân hàng PVcombank', 'Cà Mau ', 'Quảng Nam', '0545213328', '0313547643', 'AmosAbrams@gmail.com', 'Ngọc ', '1972-09-30 17:10:48', 'Duy Cường', '1987-08-22 16:31:05'),
('565c3832-2fbc-2ad0-4735-0028ed526dd0', 'NV-2054', 'Hoàng Mỹ Hằng', '1971-03-20 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '42374367', '2008-05-19 07:51:06', 'Quảng Nam ', 'Giám đốc', 'Bình Định ', '86776', 'Ngân hàng Kỹ Thương Việt Nam', 'Kon Tum', 'Ninh Bình', '0874901372', '0873552321', 'Clinton.Abney968@gmail.com', 'Ngọc Lộc ', '1998-07-17 11:44:09', 'Thị Giang', '1986-09-10 20:48:15'),
('5697b103-5179-7ac3-d31d-086412a8ea97', 'NV-0331', 'Lý Văn Toản', '1970-03-26 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '77188866', '2015-10-19 09:50:39', 'Bình Định  ', 'Quản lý', 'Bắc Kạn', '17381', 'Ngân hàng HDBank', 'Bà Rịa – Vũng Tàu', 'Quảng Ninh', '0839165948', '0865231595', 'Soliz@misa.com', 'Khánh ', '1998-03-17 17:21:38', 'Ngọc Nhung', '2017-08-29 16:50:46'),
('56aaf263-3355-23ea-b8d2-89b22d10517e', 'NV-5031', 'Tăng Mộc Yến', '1977-02-23 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '46166025', '1992-05-23 19:10:00', 'An Giang  ', 'Nhân viên cấp cao', 'Điện Biên ', '30750', 'Ngân hàng Bắc Á', 'Bình Dương ', 'Phú Yên', '0373305440', '0965093921', 'HyacinthEsparza@gmail.com', 'Mỹ Thảo', '1993-04-12 02:23:06', 'Thị Nhung', '1970-01-01 00:00:07'),
('56dce332-76f0-6b9b-5080-7ed9d1ea06ea', 'NV-6592', 'Sái Mộc Nhung', '2000-09-19 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '49453997', '2012-08-01 08:56:46', 'Đắk Nông  ', 'Nhân viên cấp cao', 'Bình Thuận ', '06837', 'Ngân hàng Bản Việt', 'Bình Phước ', 'Sơn La', '0509280380', '0820622630', 'Palma@gmail.com', 'Thị Hằng', '1970-01-01 00:08:32', 'Ngọc Toản', '2005-04-25 08:57:36'),
('57cdf8c4-47e3-5560-7e41-c1ec321fe728', 'NV-6148', 'Vũ Ngọc Tuấn', '1985-08-14 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '72718024', '1973-01-17 08:32:12', 'Cao Bằng  ', 'Trưởng phòng', 'Tây Ninh', '77059', 'Ngân hàng Nam Á', 'Sơn La', 'Tây Ninh', '0704739033', '0880246790', 'JeremyHaywood255@gmail.com', 'Thị Linh', '1970-08-09 19:11:32', 'Thị Hoa', '1970-01-01 00:00:07'),
('57d4e925-6e28-208d-9741-c1ec321fe728', 'NV-8065', 'Phạm Văn Cường', '1951-01-04 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '21370100', '1970-01-01 00:00:04', 'Đồng Nai  ', 'Phó phòng', 'Cà Mau ', '10825', 'Ngân hàng PVcombank', 'Quảng Nam', 'An Giang ', '0509341045', '0897114731', 'Lund@gmail.com', 'Mộc Thu', '1996-03-13 16:13:54', 'Anh Yến', '2006-12-04 22:50:51'),
('57dc4273-5c51-4aea-4d35-0028ed526dd0', 'NV-4278', 'Lê Thị Hằng', '1975-07-29 00:00:00', 2, '469b3ece-744a-45d5-957d-e8c757976496', '75299896', '1976-07-02 17:11:04', 'Nam Định ', 'Nhân viên', 'Cà Mau ', '46720', 'Ngân hàng PVcombank', 'Ninh Thuận', 'Quảng Nam', '0925380572', '0810315499', 'Close@gmail.com', 'Ngọc Hằng', '1972-03-05 01:26:28', 'Văn Hiệp', '2013-07-10 05:31:26'),
('57e65423-37f0-74b0-71f6-423b4e874d0f', 'NV-5987', 'Lê Ngọc ', '1994-08-01 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '15110499', '1999-11-04 05:53:28', 'Lâm Đồng ', 'Giám đốc', 'Cần Thơ ', '66071', 'Ngân hàng An Bình', 'Lào Cai', 'Bà Rịa – Vũng Tàu', '0894050939', '0964589104', 'HienCosby7@gmail.com', 'Văn Lâm ', '1980-01-14 06:03:19', 'Văn Duy', '1975-06-20 19:33:05'),
('58afd6b5-2205-64f6-9341-c1ec321fe728', 'NV-1142', 'Quảng Thị Yến', '1971-10-05 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '31897273', '1970-01-01 02:06:23', 'Lạng Sơn ', 'Phó phòng', 'Bình Phước ', '42808', 'Ngân hàng Đông Nam Á', 'Lai Châu', 'Ninh Thuận', '0579826541', '0359687089', 'Arnoldo_Altman@gmail.com', 'Ngọc Hoa', '2010-07-19 11:40:16', 'Duy Huy', '1970-01-01 00:03:46'),
('58e49fff-2a42-4ce7-1c77-d9ebc53aac3d', 'NV-6685', 'Trần  Mộc Ngọc', '1954-07-23 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '38458877', '2012-02-22 20:07:36', 'Lào Cai ', 'Nhân viên', 'Lào Cai', '92445', 'Ngân hàng VPBank', 'Bắc Kạn', 'Lai Châu', '0581299755', '0382942766', 'NapoleonCavazos86@gmail.com', 'Thị Yến', '1973-09-01 16:12:18', 'Thị Yến', '1970-01-01 00:00:06'),
('592aba45-4643-52ff-c1d2-89b22d10517e', 'NV-8073', 'Trần  Mộc Hằng', '1987-01-06 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '70344650', '2003-09-22 10:36:50', 'Lạng Sơn ', 'Giám đốc', 'Bình Dương ', '08042', 'Ngân hàng Bản Việt', 'Tây Ninh', 'Lào Cai', '0865461127', '0846009794', 'Brower@gmail.com', 'Văn Quang', '1970-01-01 00:00:49', 'Thị Hà', '1970-01-01 02:44:16'),
('5957cf32-7c84-1987-1635-60b3ebf808a9', 'NV-9762', 'Dương Duy Hiệp', '1951-09-25 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '97068282', '1970-01-01 00:04:28', 'Bắc Kạn ', 'Phó phòng', 'Quảng Nam', '47272', 'Ngân hàng Hàng Hải Việt Nam', 'Nam Định', 'Cần Thơ ', '0980107843', '0798023938', 'Wilson.Reno@misa.com', 'Văn Tuấn', '1970-01-01 00:10:59', 'An Hà', '1970-01-01 01:42:51'),
('595e7d51-318c-39e8-1377-d9ebc53aac3d', 'NV-7475', 'Lý Thị Yến', '1956-02-27 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '68340749', '1990-11-30 11:28:56', 'Nghệ An ', 'Quản lý', 'Sóc Trăng', '15156', 'Ngân hàng Phương Đông', 'Đồng Nai ', 'Bình Định ', '0374225391', '0865712659', 'MccannR2@gmail.com', 'Mỹ Vân', '2000-08-10 09:42:32', 'Ngọc Toản', '2006-09-05 04:02:09'),
('59a2f614-253e-1202-6480-7ed9d1ea06ea', 'NV-1744', 'Vũ Văn Cường', '1951-03-12 00:00:00', 2, '469b3ece-744a-45d5-957d-e8c757976496', '40170008', '1970-01-01 00:01:11', 'Sóc Trăng ', 'Quản lý', 'Bắc Giang', '36908', 'Ngân hàng An Bình', 'Đà Nẵng ', 'Phú Thọ', '0723631519', '0581199355', 'znnf6614@misa.com', 'Mỹ Hằng', '2007-12-21 05:58:56', 'Khánh Hằng', '2004-02-04 18:26:57'),
('5a841b92-791c-78df-5180-7ed9d1ea06ea', 'NV-3376', 'Tào Duy Toản', '1998-06-15 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '85252943', '2017-11-24 01:55:56', 'Lạng Sơn ', 'Quản lý', 'Bình Định ', '68634', 'Ngân hàng Đông Nam Á', 'Nghệ An', 'Ninh Bình', '0857321519', '0798595574', 'MerleFite4@misa.com', 'Văn Nhật', '1970-01-01 01:37:34', 'Anh Hiền', '1970-01-01 00:00:54'),
('5c762b70-6ca3-4343-2880-de64d090a2c2', 'NV-1900', 'Huỳnh Khánh Toản', '1951-02-05 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '90593307', '1970-01-01 00:00:36', 'Bạc Liêu  ', 'Thực tập sinh', 'Bến Tre ', '79914', 'Ngân hàng Bản Việt', 'Lào Cai', 'Quảng Ngãi', '0528918792', '0522457950', 'GrierE9@gmail.com', 'Khánh Toản', '1989-11-28 04:42:35', 'Thị Linh', '1970-01-01 00:00:24'),
('5c7f0ec4-77f2-3794-cf1d-086412a8ea97', 'NV-4136', 'Tăng Mộc Linh', '1953-05-17 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '53867285', '1970-01-01 00:14:28', 'Đắk Nông  ', 'Nhân viên', 'Ninh Bình', '22148', 'Ngân hàng HDBank', 'Đắk Nông ', 'Nghệ An', '0564152601', '0873221974', 'GusBurnett741@misa.com', 'Anh Yến', '1998-01-13 18:36:03', 'Khánh Toản', '1992-01-25 12:30:59'),
('5c85f9f2-1de1-4f0a-3e35-0028ed526dd0', 'NV-8851', 'Quách Hải Tuấn', '1969-09-11 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '08666765', '1974-07-12 01:10:41', 'Ninh Bình ', 'Phó phòng', 'Lâm Đồng', '67374', 'Ngân hàng Đông Á', 'Bắc Ninh ', 'Điện Biên ', '0517081821', '0871985056', 'Bowlin@misa.com', 'Minh Toản', '1975-08-25 02:38:20', 'Thị Hằng', '2003-01-21 16:49:02'),
('5cc649e9-60e1-5050-5435-0028ed526dd0', 'NV-7302', 'Tán Văn Minh', '1951-02-23 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '16485330', '1970-01-01 00:00:54', 'An Giang  ', 'Quản lý', 'Cần Thơ ', '69878', 'Ngân hàng Đông Nam Á', 'Quảng Trị', 'Quảng Ninh', '0894567124', '0854684636', 'Hughey345@misa.com', 'Ngọc Yến', '1987-06-13 04:19:28', 'Anh Yến', '1970-01-01 01:40:33'),
('5dc832b0-169a-1395-37c2-579daad24557', 'NV-7183', 'Vũ Khánh Yến', '1951-01-22 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '46453180', '1970-01-01 00:00:22', 'Điện Biên  ', 'Thực tập sinh', 'Sóc Trăng', '13645', 'Ngân hàng Đông Á', 'Bình Định ', 'Nghệ An', '0573690116', '0704403240', 'Abrams@gmail.com', 'Mộc Hằng', '1970-01-01 01:46:50', 'Khánh Lâm ', '1970-01-01 02:32:26'),
('5de704c2-573f-1a71-1a80-de64d090a2c2', 'NV-4963', 'Quang Ngọc Nhung', '1951-01-07 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '34222326', '1970-01-01 00:00:07', 'Cần Thơ  ', 'Nhân viên cấp cao', 'Cà Mau ', '95168', 'Ngân hàng VPBank', 'Ninh Thuận', 'Cao Bằng ', '0838205022', '0705320454', 'bpvzv8726@gmail.com', 'Thị Yến', '2010-01-20 18:16:46', 'Văn Dũng', '2017-05-29 01:10:28'),
('5e07660f-437a-6b63-4ac2-579daad24557', 'NV-2822', 'Sử Khánh Nhung', '1955-05-11 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '03851223', '2000-08-29 00:36:57', 'Kon Tum ', 'Thực tập sinh', 'Nghệ An', '52803', 'Ngân hàng Hàng Hải Việt Nam', 'Bà Rịa – Vũng Tàu', 'Lâm Đồng', '0764912894', '0798828095', 'Duane_Lord51@gmail.com', 'Thị Hà', '1970-01-01 00:12:23', 'Thị Phương', '1977-08-06 00:49:47'),
('5eaa6527-768d-3ae7-1977-d9ebc53aac3d', 'NV-6492', 'Lưu Văn Toản', '1957-05-27 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '46828524', '2006-05-07 13:31:34', 'Bình Phước  ', 'Thực tập sinh', 'Sơn La', '53273', 'Ngân hàng Đông Á', 'Lai Châu', 'Quảng Ngãi', '0389248566', '0738397505', 'Alfaro@gmail.com', 'Văn Nam ', '2008-01-01 19:25:42', 'Duy Nam ', '1975-01-18 01:54:32'),
('5edb2be2-7849-4909-c2d2-89b22d10517e', 'NV-6042', 'Đặng Văn Huy', '1951-01-05 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '56817849', '1970-01-01 00:00:05', 'Bình Định  ', 'Trưởng phòng', 'Sơn La', '71256', 'Ngân hàng VPBank', 'Bắc Giang', 'Tây Ninh', '0973334171', '0837350857', 'Curley673@misa.com', 'Khánh Hưng.', '1980-04-16 21:49:05', 'Duy Toản', '2003-07-01 03:43:45'),
('5f03d745-7702-1c85-2bc2-579daad24557', 'NV-7361', 'Đinh Duy Minh', '1973-03-14 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '90692960', '2012-06-18 00:26:18', 'Đà Nẵng  ', 'Nhân viên cấp cao', 'Đắk Lắk ', '21454', 'Ngân hàng An Bình', 'Bạc Liêu ', 'Lào Cai', '0398947993', '0848720515', 'Basham@misa.com', 'Thị Thảo', '1997-07-20 23:50:02', 'Thị Hạnh', '1970-01-01 00:05:05'),
('5f4b1d0a-247b-7049-4435-0028ed526dd0', 'NV-8213', 'Hoàng Thị Hương', '1951-01-07 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '98801810', '1970-01-01 00:00:07', 'Nghệ An ', 'Trưởng phòng', 'Phú Yên', '19373', 'Ngân hàng Kỹ Thương Việt Nam', 'Bến Tre ', 'Đồng Nai ', '0318262585', '0789919344', 'Rose@gmail.com', 'Ngọc Yến', '1988-06-07 15:58:36', 'Thị Nga', '1970-01-01 00:00:50'),
('5fab4ff7-1b8e-64d0-1880-de64d090a2c2', 'NV-3493', 'Tào An Hoa', '1955-04-11 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '59304332', '1976-06-17 18:49:53', 'Lào Cai ', 'Giám đốc', 'Bắc Giang', '06222', 'Ngân hàng Phương Đông', 'Bắc Giang', 'Bình Định ', '0596522846', '0864410912', 'Antonina_H.Criswell@misa.com', 'Ngọc Hiền', '2013-06-25 04:34:26', 'Thị Trang', '1998-03-27 12:32:59'),
('5fb9392a-4ad5-1fe7-76f6-423b4e874d0f', 'NV-2257', 'Tề Văn Toản', '1996-11-21 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '07810892', '1997-12-19 07:48:06', 'Nam Định ', 'Trưởng phòng', 'Bình Thuận ', '40739', 'Ngân hàng Bắc Á', 'An Giang ', 'Đắk Lắk ', '0842876274', '0896614588', 'VirgilCarmichael45@gmail.com', 'Văn Toản', '1984-12-03 20:36:04', 'Văn Tuấn', '1985-02-13 16:08:35'),
('5fd0a411-5945-70f7-4a35-0028ed526dd0', 'NV-5273', 'Hoàng Văn Tùng', '1965-03-01 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '02325187', '1999-07-23 04:07:16', 'Bắc Ninh  ', 'Quản lý', 'Lai Châu', '22172', 'Ngân hàng Quân đội', 'Tây Ninh', 'Bình Định ', '0390731748', '0365033194', 'Vincent@gmail.com', 'Thị Hằng', '2005-11-17 16:41:03', NULL, '1998-05-31 00:02:21'),
('60b57ac2-2e01-384d-2980-de64d090a2c2', 'NV-0255', 'Sầm Thị Nhung', '1988-05-05 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '44761135', '1990-04-26 08:34:10', 'Bắc Kạn ', 'Thực tập sinh', 'Cần Thơ ', '97626', 'Ngân hàng Kỹ Thương Việt Nam', 'Quảng Trị', 'Đắk Lắk ', '0539954687', '0553654916', 'AngleHuntington248@gmail.com', 'Khánh Toản', '2015-01-29 15:47:36', 'Thị Anh', '1970-01-01 00:10:41'),
('60fa924e-77de-55f3-2377-d9ebc53aac3d', 'NV-0451', 'Tào Văn Cường', '1992-04-10 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '32292361', '1986-11-18 03:10:30', 'Nghệ An ', 'Giám đốc', 'Bạc Liêu ', '46588', 'Ngân hàng An Bình', 'Cần Thơ ', 'Quảng Trị', '0520797631', '0715592950', 'CarolynnAndrade@misa.com', 'Văn Tuấn', '2002-04-07 06:56:11', NULL, '2002-05-28 08:52:03'),
('611bb57c-5f6c-434c-c5d2-89b22d10517e', 'NV-7306', 'Tề Anh Toản', '1958-06-25 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '39324588', '1970-01-01 00:45:33', 'Bình Định  ', 'Quản lý', 'Bắc Kạn', '55585', 'Ngân hàng An Bình', 'Bắc Giang', 'Phú Thọ', '0532894749', '0747224806', 'Columbus.URedman@gmail.com', 'Mộc Linh', '1979-07-24 12:54:36', 'Khánh Hạnh', '1975-05-12 07:32:04'),
('613afd47-2fc1-15ed-0735-60b3ebf808a9', 'NV-0165', 'Lý An Minh', '1951-01-06 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '91269386', '1970-01-01 00:00:06', 'Phú Yên ', 'Quản lý', 'Đà Nẵng ', '03573', 'Ngân hàng Phương Đông', 'Bà Rịa – Vũng Tàu', 'Bình Dương ', '0308777665', '0957265514', 'Colton.Villalobos313@misa.com', 'Thị Phương', '1981-08-08 23:37:00', NULL, '2017-05-28 11:42:02'),
('619ecbc4-37bc-19ea-6ff6-423b4e874d0f', 'NV-5310', 'Phạm Mộc Nhung', '1951-04-01 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '12238487', '1970-01-01 00:01:31', 'Quảng Ngãi ', 'Phó phòng', 'Cao Bằng ', '40165', 'Ngân hàng HDBank', 'Nghệ An', 'An Giang ', '0868360407', '0927880969', 'Joe.LHobbs721@gmail.com', 'Mộc Thu', '2009-06-05 18:08:44', 'Văn Tuấn', '2000-02-07 20:47:20'),
('61cc168f-3524-218a-2b80-de64d090a2c2', 'NV-6265', 'Đặng Mộc Hà', '1951-01-04 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '48195016', '1970-01-01 00:00:04', 'Lai Châu ', 'Quản lý', 'Bắc Ninh ', '76528', 'Ngân hàng Bắc Á', 'Nghệ An', 'Bạc Liêu ', '0847593047', '0533766192', 'Fulton5@gmail.com', 'Mỹ Linh', '1970-12-12 23:45:37', NULL, '1992-10-15 20:33:12'),
('623727c0-4fb7-573d-c3d2-89b22d10517e', 'NV-6421', 'Bùi Văn Hiệp', '1997-11-07 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '19590307', '1999-12-01 23:19:35', 'Bắc Kạn ', 'Nhân viên cấp cao', 'Đồng Nai ', '53668', 'Ngân hàng PVcombank', 'Sơn La', 'Tây Ninh', '0500117415', '0728991473', 'JaimeE.Stockton@gmail.com', 'Mỹ Hiền', '1981-02-20 18:34:53', 'Minh Tùng', '2012-06-07 12:56:00'),
('62563348-7bd5-6519-3c35-0028ed526dd0', 'NV-4059', 'Nguyễn Khánh Tùng', '1999-10-15 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '09052424', '1970-05-07 19:13:57', 'Đắk Lắk  ', 'Giám đốc', 'Bắc Ninh ', '95658', 'Ngân hàng Hàng Hải Việt Nam', 'Sóc Trăng', 'Bình Phước ', '0303284464', '0395685279', 'Loftis@gmail.com', 'Khánh Giang', '2020-01-12 17:15:13', 'Khánh Hương', '2005-09-01 17:56:44'),
('62af2231-78a7-7caa-cd1d-086412a8ea97', 'NV-0946', 'Vũ Ngọc Toản', '1966-11-16 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '86876337', '1988-10-10 08:53:23', 'Bắc Ninh  ', 'Quản lý', 'Cần Thơ ', '34662', 'Ngân hàng Hàng Hải Việt Nam', 'An Giang ', 'Bắc Ninh ', '0516936682', '0973012377', 'Henry8@gmail.com', 'Văn Tuấn', '1982-05-03 00:24:39', 'Hải Luân', '2009-01-06 15:22:57'),
('6349b25b-78e2-2d06-2780-de64d090a2c2', 'NV-5209', 'Nguyễn Thị Hương', '1959-02-27 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '10564058', '1980-08-06 21:20:20', 'Bắc Kạn ', 'Thực tập sinh', 'Phú Yên', '29106', 'Ngân hàng Á Châu', 'Sơn La', 'Lào Cai', '0967390178', '0712609135', 'JamelC.Singer389@misa.com', 'Văn Hưng.', '2004-12-18 16:44:23', 'Thị Hoa', '1991-11-28 05:14:37'),
('6385cdf4-650b-6946-7cf6-423b4e874d0f', 'NV-3725', 'Phan Văn Tuấn', '1951-04-22 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '43765328', '1970-01-01 00:01:52', 'Bắc Kạn ', 'Thực tập sinh', 'Đà Nẵng ', '02231', 'Ngân hàng Tiên Phong', 'Bình Định ', 'Bình Thuận ', '0817989055', '0364776391', 'Vanita.O_Hood329@gmail.com', 'Thị Nhung', '1970-01-01 00:00:53', NULL, '1975-11-24 11:04:46'),
('6399a2a5-2afd-3384-da1d-086412a8ea97', 'NV-2803', 'Đinh Anh Hà', '1961-08-10 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '73101621', '2011-05-05 19:34:08', 'Bà Rịa – Vũng Tàu ', 'Nhân viên cấp cao', 'Tây Ninh', '93698', 'Ngân hàng Tiên Phong', 'Đắk Nông ', 'Bắc Kạn', '0852929670', '0829346570', 'Redmond916@misa.com', 'Duy Toản', '1970-01-01 00:00:09', 'Thị Hằng', '1970-01-01 01:41:18'),
('6485b64f-7835-65a4-8041-c1ec321fe728', 'NV-2383', 'Dương An Hiếu', '1951-03-03 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '28648314', '1970-01-01 00:01:02', 'Sơn La ', 'Quản lý', 'Lạng Sơn', '50025', 'Ngân hàng Quân đội', 'Đà Nẵng ', 'Tây Ninh', '0744475821', '0537868324', 'Condon79@misa.com', 'Thị Yến', '2011-09-07 06:39:51', 'Văn ', '2003-06-03 20:23:13'),
('65334c99-4eec-773c-2c77-d9ebc53aac3d', 'NV-0756', 'Hoàng Văn Toản', '1999-03-13 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '26028470', '2006-01-01 21:43:48', 'Điện Biên  ', 'Thực tập sinh', 'Kon Tum', '21298', 'Ngân hàng VPBank', 'Bà Rịa – Vũng Tàu', 'An Giang ', '0533686206', '0343510634', 'Blake.Pounds@gmail.com', 'Duy Nguyên', '1994-05-06 15:58:15', 'Ngọc Hoa', '1990-06-02 21:41:54'),
('65ecf5c2-5298-156e-d51d-086412a8ea97', 'NV-9601', 'Lê Khánh Quang', '1951-01-10 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '43126807', '1970-01-01 00:00:10', 'Quảng Ngãi ', 'Nhân viên cấp cao', 'Bình Phước ', '81406', 'Ngân hàng PVcombank', 'Quảng Ngãi', 'Cần Thơ ', '0906152534', '0835781775', 'Staley@misa.com', 'Mỹ Thảo', '1992-10-27 03:27:58', 'Văn Trung', '1996-05-04 03:32:28'),
('66ef0b11-1892-1443-1877-d9ebc53aac3d', 'NV-1474', 'Phạm Văn Minh', '1963-08-15 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '60906523', '2000-06-13 01:04:44', 'Sơn La ', 'Trưởng phòng', 'Đắk Lắk ', '82929', 'Ngân hàng HDBank', 'Bến Tre ', 'Ninh Thuận', '0527856550', '0999358824', 'WildaSheehan@gmail.com', 'An Nam ', '2018-06-05 10:52:17', 'Khánh Thảo', '1970-01-01 00:00:02'),
('677132b4-2a33-68d1-26c2-579daad24557', 'NV-7292', 'Sùng Khánh Thảo', '1993-02-05 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '67505134', '1997-09-19 01:42:04', 'Lạng Sơn ', 'Nhân viên', 'Bạc Liêu ', '26120', 'Ngân hàng Bản Việt', 'Lai Châu', 'Quảng Ngãi', '0577960606', '0301216949', 'Allen.F_Valadez@gmail.com', 'Thị Hiền', '2001-02-03 00:31:10', 'Anh Yến', '1970-01-01 00:00:01'),
('67e3818b-56b7-4eb0-5c80-7ed9d1ea06ea', 'NV-0922', 'Lục Anh Huy', '1951-02-10 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '46661227', '1970-01-01 00:00:41', 'Quảng Nam ', 'Quản lý', 'Đà Nẵng ', '60088', 'Ngân hàng Quân đội', 'Sóc Trăng', 'Bình Thuận ', '0747832686', '0393189509', 'Crump@gmail.com', 'Mộc Thảo', '2020-12-04 20:49:22', 'Văn Tùng', '2005-04-25 12:48:39'),
('68c6083a-3e64-63ed-49c2-579daad24557', 'NV-7274', 'Phan Mộc Phương', '1954-09-29 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '31883999', '1977-02-09 03:43:20', 'Phú Yên ', 'Thực tập sinh', 'Bắc Kạn', '51663', 'Ngân hàng Tiên Phong', 'Đồng Tháp ', 'Đà Nẵng ', '0884218157', '0768284475', 'DaronPetersen@misa.com', 'Mộc Trang', '1998-11-19 03:58:01', 'Mộc Ngọc', '2002-06-29 01:05:57'),
('6a50ecc3-384e-2a54-2177-d9ebc53aac3d', 'NV-5070', 'Tăng Văn Sơn', '1986-11-21 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '74050522', '2000-03-15 17:42:53', 'Đồng Tháp  ', 'Nhân viên', 'Nghệ An', '95625', 'Ngân hàng Bản Việt', 'Phú Thọ', 'Phú Thọ', '0736832353', '0776178990', 'Adela_Alston@misa.com', 'Mộc Thu', '1970-01-01 00:00:54', 'Văn Hiệp', '1973-12-07 05:14:48'),
('6a763a51-4322-5c5a-b5d2-89b22d10517e', 'NV-3364', 'Lý Anh Yến', '1969-10-03 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '35678089', '2011-05-22 07:39:11', 'Điện Biên  ', 'Giám đốc', 'Quảng Bình', '60938', 'Ngân hàng PVcombank', 'Ninh Bình', 'Lạng Sơn', '0325087606', '0806666802', 'RandellJ_Chism185@misa.com', 'Minh Duy', '2015-08-05 18:05:13', 'Duy Hiệp', '1992-08-14 13:44:08'),
('6b003232-3bbd-7f5b-2f77-d9ebc53aac3d', 'NV-5923', 'Tán Ngọc Hoa', '1951-01-04 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '99760120', '1970-01-01 00:00:04', 'Phú Yên ', 'Nhân viên cấp cao', 'Quảng Ngãi', '47380', 'Ngân hàng Phương Đông', 'Kon Tum', 'Phú Thọ', '0546260827', '0844395673', 'CochranK71@gmail.com', 'Mộc Hương', '1972-01-28 17:35:49', 'Mỹ Yến', '1970-01-01 00:00:07'),
('6b12b154-39d3-1a5b-2280-de64d090a2c2', 'NV-9703', 'Quán Khánh Hiếu', '1965-10-17 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '46823509', '2000-02-06 09:01:37', 'Lào Cai ', 'Phó phòng', 'Quảng Trị', '64850', 'Ngân hàng VPBank', 'Nghệ An', 'Lâm Đồng', '0774928119', '0901977122', 'Priest826@gmail.com', 'An Anh', '1984-01-03 01:30:25', 'Anh Huy', '2012-10-07 14:31:54'),
('6b3600cd-500f-4faf-5035-0028ed526dd0', 'NV-1008', 'Phạm Thị Nhung', '1984-03-30 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '22864550', '1988-06-28 14:31:54', 'Bình Định  ', 'Nhân viên cấp cao', 'Nghệ An', '88073', 'Ngân hàng An Bình', 'Quảng Bình', 'Nghệ An', '0385389409', '0816239070', 'AdolphPotts@gmail.com', 'Hải Hiệp', '1970-01-01 00:06:23', 'Thị Thảo', '1970-01-01 00:01:06'),
('6b45cb9f-6de5-7a17-2d77-d9ebc53aac3d', 'NV-8514', 'Tấn Khánh Hưng.', '1961-06-03 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '68653125', '2002-03-23 12:10:51', 'Nghệ An ', 'Trưởng phòng', 'Lạng Sơn', '58940', 'Ngân hàng Tiên Phong', 'Cần Thơ ', 'Bình Định ', '0819535654', '0905367067', 'ClydeLombardo52@gmail.com', 'Thị Nhung', '1980-09-14 18:11:20', 'Khánh Toản', '1976-04-12 04:26:47'),
('6b550b8f-7ff9-51bc-0f77-d9ebc53aac3d', 'NV-1384', 'Phan Văn Tuấn', '1966-09-12 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '73830007', '1997-10-04 00:02:24', 'Cần Thơ  ', 'Quản lý', 'Ninh Thuận', '09319', 'Ngân hàng Quân đội', 'Cao Bằng ', 'Bình Thuận ', '0385373240', '0870660463', 'Scruggs@gmail.com', 'Văn Cường', '1985-11-07 11:20:31', 'Khánh Sơn', '2009-09-12 10:35:56'),
('6b76d607-7d60-38a2-5680-7ed9d1ea06ea', 'NV-0209', 'Vũ An Toản', '1956-09-02 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '70318015', '2010-12-27 21:50:23', 'Đắk Lắk  ', 'Phó phòng', 'Lạng Sơn', '04400', 'Ngân hàng Hàng Hải Việt Nam', 'Quảng Trị', 'Bình Định ', '0895652571', '0793257890', 'Cash@gmail.com', 'Khánh Thảo', '1970-01-01 00:00:45', NULL, '2018-11-11 00:10:32'),
('6b9348f5-1362-7ba5-1235-60b3ebf808a9', 'NV-9618', 'Đỗ Văn Lâm ', '1979-12-20 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '33404886', '2011-02-12 04:43:51', 'An Giang  ', 'Trưởng phòng', 'Sơn La', '94046', 'Ngân hàng Đông Á', 'Điện Biên ', 'Tây Ninh', '0705877900', '0567964404', 'Loftin@gmail.com', 'Mộc Hà', '1979-11-24 21:09:55', 'Thị Hoa', '2013-09-30 21:23:50'),
('6bb2a723-7c18-1df2-0b35-60b3ebf808a9', 'NV-7051', 'Quảng Mộc Thu', '1997-03-30 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '54818191', '2008-06-18 14:26:41', 'Bắc Kạn ', 'Quản lý', 'Bình Dương ', '40590', 'Ngân hàng Đông Á', 'Bến Tre ', 'Lào Cai', '0966202001', '0714018397', 'LargeC99@gmail.com', 'Mộc Anh', '1973-08-14 11:54:41', 'Duy Toản', '1971-08-22 09:08:13'),
('6c5b9fe7-14c9-3bb5-b4d2-89b22d10517e', 'NV-9114', 'Tán Khánh Toản', '1957-09-07 00:00:00', 2, '469b3ece-744a-45d5-957d-e8c757976496', '18017927', '1999-07-21 11:44:51', 'Lạng Sơn ', 'Phó phòng', 'Bến Tre ', '41437', 'Ngân hàng Bắc Á', 'Cà Mau ', 'Sóc Trăng', '0907657716', '0948358039', 'KristinaW_Williams@gmail.com', 'Văn Toản', '1970-01-01 00:00:06', NULL, '1973-07-31 23:13:28'),
('6c80a684-1cb5-41af-ff34-60b3ebf808a9', 'NV-3386', 'Lưu Ngọc Hằng', '1991-04-28 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '99616143', '1986-11-16 21:46:20', 'Nghệ An ', 'Nhân viên cấp cao', 'Lai Châu', '25421', 'Ngân hàng VPBank', 'Tây Ninh', 'Quảng Trị', '0920804447', '0912010219', 'Edward.B_Craddock933@misa.com', 'Thị Anh', '1975-06-25 08:20:02', 'Thị Mai', '1970-01-01 00:31:40'),
('6d489b13-7396-7986-1577-d9ebc53aac3d', 'NV-7204', 'Quách Khánh Hưng.', '1978-01-30 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '41380473', '1973-02-21 23:18:49', 'Quảng Ngãi ', 'Quản lý', 'Nam Định', '73557', 'Ngân hàng Á Châu', 'Bình Định ', 'Bắc Giang', '0370165702', '0857247047', 'Flanders@misa.com', 'Duy Tùng', '2005-07-05 01:48:55', 'Minh Toản', '1975-07-10 20:39:29'),
('6d7def1b-4b7e-52aa-8f41-c1ec321fe728', 'NV-6144', 'Võ Anh Hằng', '1968-05-24 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '05339210', '1975-09-21 08:34:37', 'Nghệ An ', 'Thực tập sinh', 'Điện Biên ', '22380', 'Ngân hàng PVcombank', 'Bắc Kạn', 'Bến Tre ', '0868443814', '0348595514', 'kcpnhj92@gmail.com', 'Thị Thảo', '1970-01-01 02:44:10', 'Khánh Hoa', '1974-07-29 08:15:26'),
('6dcdb6b6-273a-6aaa-8541-c1ec321fe728', 'NV-5263', 'Sùng Anh Anh', '1952-02-25 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '21219759', '2008-05-28 16:37:31', 'Đồng Nai  ', 'Nhân viên', 'Nghệ An', '72086', 'Ngân hàng Bắc Á', 'Phú Yên', 'Ninh Bình', '0858253219', '0965819044', 'DylanGaskin@gmail.com', 'Ngọc Hằng', '1999-01-13 08:17:32', 'Văn Cương', '1987-10-23 05:08:18'),
('6e3f7a8c-2f78-16a9-36c2-579daad24557', 'NV-6554', 'Vũ Văn Hiếu', '1982-12-22 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '58541325', '1999-08-30 08:53:50', 'Nghệ An ', 'Phó phòng', 'Bến Tre ', '56315', 'Ngân hàng HDBank', 'Cần Thơ ', 'Bắc Ninh ', '0326738887', '0706042628', 'Sikes795@gmail.com', 'Văn Toản', '1993-06-29 06:12:26', NULL, '1992-03-31 18:00:22'),
('6e5bdc72-59a2-5141-7af6-423b4e874d0f', 'NV-3390', 'Đoàn Anh Hà', '1986-07-16 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '51406205', '2010-03-29 06:30:59', 'Bắc Ninh  ', 'Nhân viên cấp cao', 'An Giang ', '10903', 'Ngân hàng Hàng Hải Việt Nam', 'Bình Phước ', 'Phú Yên', '0389552522', '0747164448', 'Augustine.Rangel3@misa.com', 'Minh Quang', '1972-02-14 06:49:21', 'Mỹ Hương', '1992-05-04 15:27:49'),
('6e60b234-643f-288e-7ff6-423b4e874d0f', 'NV-5278', 'Bùi Ngọc Giang', '1965-07-16 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '78291286', '1970-01-01 01:28:31', 'Kon Tum ', 'Trưởng phòng', 'Bà Rịa – Vũng Tàu', '23019', 'Ngân hàng An Bình', 'Lạng Sơn', 'Kon Tum', '0302073234', '0582209978', 'RochelNoble497@gmail.com', 'Thị Yến', '1970-01-01 00:04:17', 'Văn Hưng.', '1970-01-01 00:01:04'),
('6f1014db-2ff0-613b-bdd2-89b22d10517e', 'NV-8155', 'Tào Văn Dũng', '1955-07-10 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '20510927', '1970-01-01 00:27:32', 'Đà Nẵng  ', 'Phó phòng', 'Phú Yên', '93742', 'Ngân hàng Tiên Phong', 'Sơn La', 'Quảng Trị', '0954269735', '0848020772', 'Mackay@gmail.com', 'Khánh Sơn', '2015-12-26 13:18:12', 'Duy Toản', '2008-07-12 05:04:31'),
('6f51ea57-13b2-139f-1177-d9ebc53aac3d', 'NV-9280', 'Hồ Mỹ Nhung', '1974-07-10 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '20454612', '2002-10-07 08:00:06', 'Phú Thọ ', 'Thực tập sinh', 'Đà Nẵng ', '04010', 'Ngân hàng Bản Việt', 'Lạng Sơn', 'Bến Tre ', '0578118125', '0771790255', 'Siobhan.Leger@gmail.com', 'Văn Linh', '2015-11-18 22:54:17', 'Duy Huy', '2006-05-17 20:45:46'),
('707e1336-6584-55de-8341-c1ec321fe728', 'NV-6570', 'Dương Văn Nam ', '1951-03-30 00:00:00', 1, '142cb08f-7c31-21fa-8e90-67245e8b283e', '18344975', '1970-01-01 00:01:29', 'Đắk Lắk  ', 'Nhân viên cấp cao', 'Cần Thơ ', '77671', 'Ngân hàng Nam Á', 'Quảng Bình', 'Cao Bằng ', '0939513092', '0555111820', 'JuliusHorowitz69@gmail.com', 'Duy Minh', '1980-03-22 10:03:35', 'Ngọc Tuấn', '1987-08-05 14:08:09'),
('70aead00-2db5-77f7-2277-d9ebc53aac3d', 'NV-3010', 'Ngô Khánh Vân', '1979-04-30 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '48689669', '2008-05-13 21:52:28', 'Bạc Liêu  ', 'Giám đốc', 'Bạc Liêu ', '97661', 'Ngân hàng Đông Nam Á', 'Bình Dương ', 'Quảng Nam', '0712523588', '0860417038', 'tzpwbels.rdfhjmffnc@gmail.com', 'Anh Nhung', '1970-01-01 00:16:14', 'Thị Nhung', '1995-12-22 17:24:19'),
('721b7460-7378-2203-0435-60b3ebf808a9', 'NV-2526', 'Phan Mộc Thảo', '1964-02-08 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '91135421', '1972-04-07 00:44:39', 'Điện Biên  ', 'Quản lý', 'Bắc Ninh ', '17805', 'Ngân hàng Đông Nam Á', 'Quảng Nam', 'Đà Nẵng ', '0511680175', '0916116540', 'Comer@misa.com', 'Hải Cường', '1989-01-04 11:58:34', NULL, '2005-12-29 10:38:57'),
('72fe5819-3c8c-3651-cad2-89b22d10517e', 'NV-1578', 'Quảng Văn Toản', '1986-05-21 00:00:00', 0, '142cb08f-7c31-21fa-8e90-67245e8b283e', '23309194', '2019-05-26 07:21:04', 'Bà Rịa – Vũng Tàu ', 'Nhân viên', 'Sóc Trăng', '72565', 'Ngân hàng Phương Đông', 'Tây Ninh', 'Bình Thuận ', '0899380667', '0844335400', 'uyskalni.ucydnkrbv@gmail.com', 'An Nhật', '1993-12-28 08:17:21', 'Duy Toản', '1970-01-01 00:00:08'),
('73dc79e1-1ccb-35a6-0235-60b3ebf808a9', 'NV-6922', 'Phan Thị Linh', '2000-10-10 00:00:00', 1, '142cb08f-7c31-21fa-8e90-67245e8b283e', '77561203', '2007-01-15 22:25:46', 'Lai Châu ', 'Thực tập sinh', 'Quảng Nam', '69570', 'Ngân hàng Tiên Phong', 'Đà Nẵng ', 'Nghệ An', '0519391152', '0918005072', 'HoseaCBlake@misa.com', 'An Nhung', '1970-01-01 02:03:38', 'Minh Nam ', '1973-06-24 16:47:32'),
('75ec2fe2-5965-48e6-9141-c1ec321fe728', 'NV-9014', 'Nguyễn Duy Toản', '1974-09-15 00:00:00', 2, '469b3ece-744a-45d5-957d-e8c757976496', '92065571', '2000-09-07 22:39:02', 'Bạc Liêu  ', 'Quản lý', 'Nghệ An', '44018', 'Ngân hàng Tiên Phong', 'Quảng Nam', 'Đà Nẵng ', '0993874651', '0573225096', 'Lenny.Watson51@misa.com', 'Khánh Phương', '1990-12-27 12:26:48', 'Khánh Hà', '2014-02-01 03:28:55'),
('762cf9e5-356b-56d7-5f80-7ed9d1ea06ea', 'NV-2410', 'Ngô Ngọc Hoa', '1967-11-02 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '31317033', '1970-01-01 01:42:30', 'Kon Tum ', 'Thực tập sinh', 'Bến Tre ', '36367', 'Ngân hàng VPBank', 'Ninh Bình', 'Đồng Nai ', '0712621655', '0920655717', 'Irving_Cummings@gmail.com', 'Thị Hiền', '1990-02-15 22:19:25', 'Thị Hương', '1978-03-29 20:41:50'),
('7649b7c1-509e-4f94-6580-7ed9d1ea06ea', 'NV-1658', 'Phan Anh Nam ', '1991-06-17 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '45155654', '1984-08-19 03:56:12', 'Ninh Thuận ', 'Giám đốc', 'Quảng Bình', '54168', 'Ngân hàng Đông Nam Á', 'Bình Thuận ', 'Quảng Ninh', '0824280267', '0300483300', 'bkpmrn4@gmail.com', 'Khánh Yến', '2016-03-29 12:00:19', 'Văn Lộc ', '2003-05-11 05:36:27'),
('76b3b772-27f3-37bf-75f6-423b4e874d0f', 'NV-5376', 'Đinh Mỹ Thảo', '1974-01-16 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '48859465', '2000-08-06 01:34:26', 'Đà Nẵng  ', 'Nhân viên', 'Đắk Nông ', '05617', 'Ngân hàng Đông Nam Á', 'Bình Dương ', 'Kon Tum', '0805514513', '0939882552', 'Abraham9@gmail.com', 'Mộc Huyền', '2007-09-14 12:46:24', 'Minh Quang', '1987-11-27 22:03:19'),
('76cc3313-3932-7e97-4635-0028ed526dd0', 'NV-7659', 'Bùi Khánh Giang', '1997-12-15 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '14977592', '2005-04-12 01:16:36', 'Đà Nẵng  ', 'Nhân viên', 'Đắk Nông ', '29925', 'Ngân hàng Đông Nam Á', 'Quảng Bình', 'Cần Thơ ', '0847274040', '0314002240', 'Jeffrey@gmail.com', 'Anh Sơn', '1991-07-19 07:12:27', 'Văn Bảo ', '2005-09-08 01:42:01'),
('778c67bd-6967-345e-2e77-d9ebc53aac3d', 'NV-5802', 'Quàng Thị Linh', '1964-01-26 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '33859450', '1980-09-11 19:51:48', 'Bình Định  ', 'Nhân viên cấp cao', 'Đắk Nông ', '14815', 'Ngân hàng Quân đội', 'Phú Thọ', 'Tây Ninh', '0364810518', '0838272107', 'Barrett673@misa.com', 'Thị Nhung', '1987-05-06 00:35:33', 'Thị Nhung', '1995-07-09 21:16:51'),
('77d03350-6ba4-226c-77f6-423b4e874d0f', 'NV-0634', 'Tăng Khánh Huyền', '1953-05-09 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '73115683', '1970-01-01 00:14:20', 'Cần Thơ  ', 'Phó phòng', 'Quảng Bình', '84069', 'Ngân hàng Quân đội', 'Sóc Trăng', 'Ninh Bình', '0972232465', '0869939042', 'Back654@gmail.com', 'Khánh ', '2018-04-13 12:59:48', 'Anh Hiệp', '1978-08-15 20:00:51'),
('78b1d514-338c-3cdc-8641-c1ec321fe728', 'NV-3352', 'Dương Duy ', '1951-01-08 00:00:00', 2, '17120d02-6ab5-3e43-18cb-66948daf6128', '18734699', '1970-01-01 00:00:08', 'Quảng Bình ', 'Quản lý', 'Bình Thuận ', '44887', 'Ngân hàng Kỹ Thương Việt Nam', 'An Giang ', 'Bình Phước ', '0303361629', '0716387801', 'zbpq00@gmail.com', 'Văn Tuấn', '2012-06-18 13:27:43', 'Ngọc ', '1970-01-01 00:01:23'),
('7976650d-4e86-2615-8c41-c1ec321fe728', 'NV-9116', 'Lương Khánh Nga', '1955-02-04 00:00:00', 2, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '20241736', '1997-07-19 18:29:58', 'Cao Bằng  ', 'Trưởng phòng', 'Điện Biên ', '08644', 'Ngân hàng Tiên Phong', 'Cà Mau ', 'Cà Mau ', '0874810727', '0809707989', 'Horne@misa.com', 'Mộc Phương', '1970-01-01 00:01:30', 'Văn Đạt', '2007-04-26 11:54:05'),
('79806d6f-4830-6311-2577-d9ebc53aac3d', 'NV-7378', 'Lê Thị Hương', '1953-05-03 00:00:00', 0, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '49318950', '1970-01-01 00:14:14', 'Quảng Ninh ', 'Thực tập sinh', 'Đồng Tháp ', '18620', 'Ngân hàng HDBank', 'Lai Châu', 'Bắc Giang', '0929606537', '0732622234', 'lhztgqyf23@gmail.com', 'Văn Toản', '1970-11-08 23:04:46', 'Khánh Tuấn', '1990-05-18 01:49:18'),
('79dadd0d-69fa-5e30-35c2-579daad24557', 'NV-1208', 'Vũ Văn Toản', '1952-11-20 00:00:00', 2, '142cb08f-7c31-21fa-8e90-67245e8b283e', '67193655', '1988-10-20 05:57:09', 'Kon Tum ', 'Giám đốc', 'Quảng Ngãi', '27608', 'Ngân hàng Hàng Hải Việt Nam', 'Đắk Lắk ', 'Quảng Nam', '0500672518', '0597161363', 'Warner.Betts5@misa.com', 'Ngọc Nhung', '1972-07-18 00:35:22', NULL, '1971-05-21 14:05:23'),
('7a1114ad-76c4-3734-1f77-d9ebc53aac3d', 'NV-9874', 'Dương Duy Tùng', '1969-06-26 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '41663174', '1993-11-28 02:19:41', 'Bình Thuận  ', 'Giám đốc', 'Lạng Sơn', '55427', 'Ngân hàng Phương Đông', 'Nghệ An', 'Lai Châu', '0714858102', '0584370824', 'Eloy_N.Christiansen@gmail.com', 'Thị Thảo', '1973-11-30 05:36:23', 'Duy Tuấn', '1970-01-01 00:01:01'),
('7a301ea4-331e-73f6-1a77-d9ebc53aac3d', 'NV-4423', 'Đỗ Anh Yến', '1970-12-10 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '57480046', '1972-12-27 02:38:51', 'Bình Định  ', 'Quản lý', 'Bến Tre ', '11560', 'Ngân hàng An Bình', 'Bạc Liêu ', 'Sơn La', '0866264542', '0968834329', 'GillG511@gmail.com', 'Văn Toản', '2014-12-08 09:03:39', 'Thị Anh', '2014-08-26 13:29:13'),
('7a3fbd10-76db-716b-48c2-579daad24557', 'NV-4447', 'Tề Minh Tùng', '1953-09-03 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '45322338', '1970-01-01 00:16:17', 'Ninh Bình ', 'Trưởng phòng', 'Bắc Giang', '70227', 'Ngân hàng Quân đội', 'Quảng Ngãi', 'Cao Bằng ', '0979260969', '0362982595', 'Abel2@gmail.com', 'Khánh Hà', '1973-09-30 12:54:19', 'Khánh Bảo ', '2013-07-29 11:16:38'),
('7ad34860-1ac8-7ad7-d01d-086412a8ea97', 'NV-6661', 'Hồ Anh Thảo', '1951-01-12 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '22201253', '1970-01-01 00:00:12', 'Đồng Tháp  ', 'Nhân viên', 'Bà Rịa – Vũng Tàu', '63492', 'Ngân hàng Đông Á', 'Bà Rịa – Vũng Tàu', 'Bình Dương ', '0780983006', '0531443487', 'Buss@gmail.com', 'Khánh Duy', '1983-01-12 00:05:35', 'Thị Giang', '1999-03-09 09:08:38'),
('7b666cc3-1b67-6037-67f6-423b4e874d0f', 'NV-0229', 'Lý Anh Yến', '1978-10-30 00:00:00', 1, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '56407771', '1980-07-03 08:46:27', 'Sơn La ', 'Phó phòng', 'Nghệ An', '92549', 'Ngân hàng Tiên Phong', 'Quảng Ninh', 'Lâm Đồng', '0875200859', '0906442926', 'TonyBeckman@gmail.com', 'Văn Toản', '2003-07-26 12:15:14', 'Anh Hiền', '1978-04-27 08:47:55'),
('7bc9331d-7764-5dd7-80f6-423b4e874d0f', 'NV-9209', 'Phạm Mộc Hằng', '1954-05-16 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '58302811', '1989-05-26 15:55:45', 'Lai Châu ', 'Giám đốc', 'Bình Phước ', '34266', 'Ngân hàng Bắc Á', 'Bạc Liêu ', 'Bắc Kạn', '0331438265', '0855784068', 'Mcnabb@gmail.com', 'Khánh Duy', '1975-12-20 04:17:20', NULL, '1970-01-01 00:00:57'),
('7bd9cf39-3f55-3a7b-0035-60b3ebf808a9', 'NV-8669', 'Trần  Ngọc Mai', '1951-01-07 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '14056488', '1970-01-01 00:00:07', 'Đà Nẵng  ', 'Nhân viên cấp cao', 'Sóc Trăng', '72825', 'Ngân hàng PVcombank', 'Phú Thọ', 'Đồng Tháp ', '0882133562', '0730707180', 'Asher@misa.com', 'Thị Yến', '2008-05-31 08:20:34', 'Văn Toản', '2004-03-01 22:34:43'),
('7c1ae6ac-6c72-7436-2dc2-579daad24557', 'NV-6823', 'Quang Mộc Yến', '1959-05-22 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '23252060', '1982-10-01 18:11:36', 'Lào Cai ', 'Nhân viên cấp cao', 'Phú Yên', '85534', 'Ngân hàng Quân đội', 'Kon Tum', 'Bình Thuận ', '0983015921', '0348966171', 'JohanneEstep@gmail.com', 'Văn Huy', '1970-01-01 00:00:02', NULL, '1981-08-01 06:30:31'),
('7c59ba0b-4768-4115-3477-d9ebc53aac3d', 'NV-0353', 'Dương Khánh Trung', '1969-02-20 00:00:00', 0, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '89683177', '1970-01-01 01:50:26', 'Lào Cai ', 'Nhân viên', 'An Giang ', '94685', 'Ngân hàng Hàng Hải Việt Nam', 'Đồng Tháp ', 'Đắk Lắk ', '0325213364', '0715547021', 'jpfofvjk37@gmail.com', 'Minh Toản', '1970-01-01 00:00:02', NULL, '1970-01-01 00:01:05'),
('7c6c70d9-2ed5-49d8-81f6-423b4e874d0f', 'NV-1056', 'Tào Mỹ Yến', '1951-01-03 00:00:00', 1, '469b3ece-744a-45d5-957d-e8c757976496', '61437452', '1970-01-01 00:00:03', 'Nghệ An ', 'Nhân viên cấp cao', 'Đồng Nai ', '71705', 'Ngân hàng Quân đội', 'Sơn La', 'Bà Rịa – Vũng Tàu', '0712689234', '0925563783', 'Beatris.J.Kimbrough@misa.com', 'Mỹ Hằng', '1978-01-23 20:57:59', 'Mỹ Anh', '1970-01-01 00:09:48'),
('7c86746a-4284-356e-e11d-086412a8ea97', 'NV-9953', 'Lê Văn Hiếu', '1963-11-13 00:00:00', 1, '17120d02-6ab5-3e43-18cb-66948daf6128', '68127352', '1970-01-01 01:18:20', 'Lâm Đồng ', 'Thực tập sinh', 'Sóc Trăng', '49587', 'Ngân hàng Bắc Á', 'Bạc Liêu ', 'Quảng Trị', '0763702081', '0386721879', 'Jeffrey@misa.com', 'Mỹ Thảo', '1970-01-01 02:11:39', 'Mộc Anh', '1970-01-01 00:00:07'),
('7d7c8cbb-3c1b-7e12-6680-7ed9d1ea06ea', 'NV-4182', 'Tạ Duy Cương', '1988-10-20 00:00:00', 2, '469b3ece-744a-45d5-957d-e8c757976496', '37847826', '1999-07-01 12:15:22', 'Bắc Kạn ', 'Giám đốc', 'Quảng Nam', '11066', 'Ngân hàng Đông Nam Á', 'Bình Dương ', 'Nghệ An', '0545728180', '0807291071', 'Lutz@gmail.com', 'Văn Nguyên', '1984-04-13 01:45:40', 'Thị Yến', '1994-10-31 18:45:45'),
('7d817578-2d6f-7bd4-9841-c1ec321fe728', 'NV-6625', 'Sử Văn Toản', '1991-02-10 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '46133895', '2019-09-19 09:52:13', 'Tây Ninh ', 'Trưởng phòng', 'Lạng Sơn', '11092', 'Ngân hàng Đông Nam Á', 'Bến Tre ', 'Ninh Thuận', '0877048809', '0785327364', 'gplgixcc_toxise@gmail.com', 'Văn Toản', '1975-12-14 06:45:32', 'Duy Lộc ', '1978-02-23 10:02:08'),
('7d879258-5ccb-11d6-e31d-086412a8ea97', 'NV-2067', 'Tấn Duy Nguyên', '1978-10-20 00:00:00', 2, '4e272fc4-7875-78d6-7d32-6a1673ffca7c', '65919423', '1981-09-12 06:41:55', 'Phú Yên ', 'Thực tập sinh', 'Lai Châu', '54068', 'Ngân hàng An Bình', 'Đắk Nông ', 'Đồng Tháp ', '0871502105', '0342543206', 'OdisAdam@misa.com', 'Anh Thảo', '1970-01-01 00:00:11', 'Mộc Hà', '2005-02-16 09:05:42'),
('7dc15ff7-7a2b-68a9-9941-c1ec321fe728', 'NV-6394', 'Lê Duy Hậu', '1953-01-27 00:00:00', 2, '469b3ece-744a-45d5-957d-e8c757976496', '71950012', '1970-01-01 00:12:38', 'Quảng Bình ', 'Phó phòng', 'Phú Yên', '83215', 'Ngân hàng HDBank', 'Bắc Giang', 'Đồng Nai ', '0546203954', '0379541970', 'Utley@misa.com', 'Văn Toản', '1970-01-01 00:00:32', 'Duy Nam ', '2002-11-04 12:40:24'),
('7e61a689-2cd8-340e-2677-d9ebc53aac3d', 'NV-5265', 'Lục Thị Hằng', '1955-06-01 00:00:00', 0, '17120d02-6ab5-3e43-18cb-66948daf6128', '77780204', '1983-12-22 02:14:27', 'Đồng Nai  ', 'Phó phòng', 'Đà Nẵng ', '36274', 'Ngân hàng VPBank', 'Phú Thọ', 'Cao Bằng ', '0707235330', '0354027212', 'Culbertson@misa.com', 'Thị Yến', '1976-12-27 07:42:51', 'Mộc Giang', '1970-01-01 00:33:00'),
('7eebdc34-6c41-1ab4-5735-0028ed526dd0', 'NV-8270', 'Mai Mộc Hà', '1971-12-21 00:00:00', 1, '11452b0c-768e-5ff7-0d63-eeb1d8ed8cef', '96095161', '2000-09-14 00:00:00', 'Đắk Nông  ', 'Thực tập sinh', 'Bạc Liêu ', '79601', 'Ngân hàng Tiên Phong', 'Lâm Đồng', 'Lào Cai', '0857080697', '0590129074', 'Abraham@misa.com', 'Văn Cường', '2021-07-03 00:00:00', 'Duy Tuấn', '2011-12-17 00:00:00'),
('7f1b6c7c-2b74-3ebb-31c2-579daad24557', 'NV-9920', 'Lý Khánh ', '1959-04-25 00:00:00', 0, '469b3ece-744a-45d5-957d-e8c757976496', '64308550', '1970-01-01 00:50:37', 'Lạng Sơn ', 'Trưởng phòng', 'Bình Dương ', '91978', 'Ngân hàng Phương Đông', 'Cần Thơ ', 'Tây Ninh', '0916864860', '0531838458', 'uzttr2755@gmail.com', 'Thị Giang', '1970-04-02 19:57:19', 'Khánh Hương', '1970-01-01 00:16:29'),
('afc8808a-fe3f-11eb-887d-00163e047e89', 'NV-99170', 'Phan Ngọc Toản', '2000-06-15 00:00:00', 1, '142cb08f-7c31-21fa-8e90-67245e8b283e', '123456789', '2016-06-14 00:00:00', 'Nam Định', 'Nhân viên', '50 Thanh Bình, Hà Đông', '123456789', 'Agribank', 'Hà Nội', NULL, '0972826401', '0972826401', 'pntoan156@gmail.com', NULL, '2021-08-16 11:11:45', NULL, NULL);

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;