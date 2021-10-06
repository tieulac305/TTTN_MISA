// Resource dùng chung toàn chương trình
const Resource = Resource || {};

// Các formMode của formDialog
Resource.FormMode = {
    Add: "Add",
    Edit: "Edit",
    Duplicate: "Duplicate",
}

// Các popupMode của PopUp
Resource.PopUpMode = {
    Question: "question",
    Warning: "warning",
    Error: "error",
}

// Các toastMode của Toast
Resource.ToastMesengerMode = {
    Success: "success",
    Info: "info",
    Warning: "warning",
    Error: "error",
}

// các tin nhắn khi validate dữ liệu
Resource.ValidateDict = {
    EmployeeCode: {
        required: 'Không được bỏ trống mã nhân viên.',
        max: 'Mã nhân viên không quá 20 kí tự.',
    },
    EmployeeName: {
        required: 'Không được bỏ trống họ và tên.',
        max: 'Độ dài tên không quá 100 kí tự.'
    },
    Department: {
        required: 'Vui lòng chọn một đơn vị.',
    },
    EmployeePosition:{
        max: 'Chức vụ không vượt quá 255 kí tự'
    },
    IdentityNumber:{
        regex: 'Số CMND/CCCD bao gồm 9 hoặc 12 chữ số'
    },
    IdentityPlace: {
        max: 'Nơi cấp không quá 255 kí tự.',
    },
    Address:{
        max: "Địa chỉ không quá 255 kí tự"
    },
    Email: {
        regex: 'Vui lòng nhập đúng định dạng email.',
        max: 'Email không quá 50 kí tự.'
    },
    PhoneNumber: {
        regex: 'Vui lòng nhập đúng số điện thoại.',
        max: 'Số điện thoại không quá 20 kí tự.'
    },
    TelephoneNumber: {
        regex: 'Vui lòng nhập đúng số điện thoại.',
        max: 'Số điện thoại không quá 20 kí tự.'
    },
    BankAccountNumber:{
        regex: "Số tài khoản chỉ gồm các chữ số.",
        max: 'Số tài khoản không quá 20 kí tự'
    },
    BankName: {
        max: 'Tên ngân hàng không quá 255 kí tự.'
    },
    BankBranchName: {
        max: 'Tên ngân hàng không quá 255 kí tự.'
    },
}

// các lựa chọn cố định cho hộp select
Resource.SelectOptions = {
    PageSizeOptions: [
        {
            size: 10,
            name: '10 bản ghi trên 1 trang',
        },
        {
            size: 20,
            name: '20 bản ghi trên 1 trang',
        },
        {
            size: 30,
            name: '30 bản ghi trên 1 trang',
        },
        {
            size: 50,
            name: '50 bản ghi trên 1 trang',
        },
        {
            size: 100,
            name: '100 bản ghi trên 1 trang',
        },
    ],
}

// thông báo
Resource.Message = {
    Exception: 'Có lỗi xảy ra. Vui lòng thử lại sau.',
    LoadError: 'Có lỗi khi tải dữ liệu.'
}

// schema 
Resource.Schema = {
    EmployeeTable: [
        {
            fieldName: 'employeeCode',
            dataType: '',
            headerText: 'Mã nhân viên'
        },
        {
            fieldName: 'employeeName',
            dataType: '',
            headerText: 'Tên nhân viên'
        },
        {
            fieldName: 'genderName',
            dataType: '',
            headerText: 'Giới tính'
        },
        {
            fieldName: 'dateOfBirth',
            dataType: 'Date',
            headerText: 'Ngày sinh'
        },
        {
            fieldName: 'identityNumber',
            dataType: '',
            headerText: 'Số CMND'
        },
        {
            fieldName: 'employeePosition',
            dataType: '',
            headerText: 'Chức danh'
        },
        {
            fieldName: 'departmentName',
            dataType: '',
            headerText: 'Tên đơn vị'
        },
        {
            fieldName: 'bankAccountNumber',
            dataType: '',
            headerText: 'Số tài khoản'
        },
        {
            fieldName: 'bankName',
            dataType: '',
            headerText: 'Tên ngân hàng'
        },
        {
            fieldName: 'bankBranchName',
            dataType: '',
            headerText: 'Chi nhánh TK ngân hàng'
        }
    ],
    EmployeeExport: [
        {
            column: 'Mã nhân viên',
            type: String,
            width: 15,
            align: 'center',
            borderColor: '#000000',
            value: employee => employee.employeeCode
        },
        {
            column: 'Tên nhân viên',
            type: String,
            width: 20,
            borderColor: '#000000',
            value: employee => employee.employeeName
        },
        {
            column: 'Giới tính',
            type: String,
            width: 10,
            align: 'center',
            borderColor: '#000000',
            value: employee => employee.genderName
        },
        {
            column: 'Ngày sinh',
            type: Date,
            width: 15,
            format: 'dd/mm/yyyy',
            align: 'center',
            borderColor: '#000000',
            value: employee => new Date(employee.dateOfBirth)
        },
        {
            column: 'Số CMND',
            type: String,
            width: 15,
            borderColor: '#000000',
            value: employee => employee.identityNumber
        },
        {
            column: 'Chức danh',
            type: String,
            width: 20,
            borderColor: '#000000',
            value: employee => employee.employeePosition
        },
        {
            column: 'Tên đơn vị',
            type: String,
            width: 20,
            borderColor: '#000000',
            value: employee => employee.departmentName
        },
        {
            column: 'Số tài khoản',
            type: String,
            width: 15,
            borderColor: '#000000',
            value: employee => employee.bankAccountNumber
        },
        {
            column: 'Tên ngân hàng',
            type: String,
            width: 30,
            borderColor: '#000000',
            value: employee => employee.bankName
        },
        {
            column: 'CN TK ngân hàng',
            type: String,
            width: 20,
            borderColor: '#000000',
            value: employee => employee.bankBranchName
        }
    ],
    // date format cần đc truyền vào khi gọi hàm readxlsx
    // mệt quá chưa làm tới nha
    EmployeeImport: {
        'Mã nhân viên': {
            prop: 'employeeCode'
        },
        'Tên nhân viên': {
            prop: 'employeeName'
        },
        'Tên đơn vị':{
            prop: 'departmentName'
        },
        'Chức danh': {
            prop: 'employeePosition'
        },
        'Ngày sinh': {
            prop: 'dateOfBirth',
            type: Date
        },
        'Giới tính': {
            prop: 'genderName'
        },
        'Số CMND': {
            prop: 'identityNumber'
        },
        'Ngày cấp': {
            prop: 'identityDate',
            type: Date
        },
        'Nơi cấp': {
            prop: 'identityPlace'
        },
        'Địa chỉ': {
            prop: 'address'
        },
        'ĐT di động': {
            prop: 'phoneNumber'
        },
        'ĐT cố định': {
            prop: 'telephoneNumber'
        },
        'Email': {
            prop: 'email'
        },
        'Tài khoản ngân hàng': {
            prop: 'bankAccountNumber'
        },
        'Tên ngân hàng':{
            prop: 'bankName'
        },
        'Chi nhánh':{
            prop: 'bankBranchName'
        }
    }
}

export default Resource;