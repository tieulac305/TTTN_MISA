<template>
    <div class="dialog popup">
        <div class="cover-background"></div>
        <div class="modal-content d-flex">
            <div class="modal-body d-flex">
                <div>Để nhập khẩu thông tin từ tệp Excel. Vui lòng đảm bảo:</div>
                <div>
                    &emsp; 1. Tệp Excel có đuôi mở rộng là .xlsx <br>
                    &emsp; 2. Tệp Excel không có tiêu đề <br>
                    &emsp; 3. Định dạng ngày: dd/mm/yyyy <br>
                    &emsp; 4. Tệp Excel cung cấp đầy đủ các cột thông tin như bảng sau:
                </div>
                <table>
                    <tr>
                        <td>Mã nhân viên</td>
                        <td>Tên nhân viên</td>
                        <td>Tên đơn vị</td>
                    </tr>
                    <tr>
                        <td>Chức danh</td>
                        <td>Ngày sinh</td>
                        <td>Giới tính</td>
                    </tr>
                    <tr>
                        <td>Số CMND</td>
                        <td>Ngày cấp</td>
                        <td>Nơi cấp</td>
                    </tr>
                    <tr>
                        <td>Địa chỉ</td>
                        <td>ĐT di động</td>
                        <td>ĐT cố định</td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td>Tài khoản ngân hàng</td>
                        <td>Tên ngân hàng</td>
                        <td>Chi nhánh</td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer d-flex">
                <button type="button" class="btn btn-secondary"
                    @click="$emit('close')">Đóng</button>
                <button class="btn btn-primary"
                    @click="downloadSchema()">Tải xuống tệp mẫu</button>
            </div>
        </div>
    </div>
</template>

<script>
import writeXlsxFile from 'write-excel-file'

export default {
    name: 'ImportHelpDialog',
    methods:{
        downloadSchema(){
            const headerCell = {fontWeight: 'bold', borderColor: '#000000', align: 'center'};
            const data = [
                [
                    {...headerCell, value: 'Mã nhân viên'},
                    {...headerCell, value: 'Tên nhân viên'},
                    {...headerCell, value: 'Tên đơn vị'},
                    {...headerCell, value: 'Chức danh'},
                    {...headerCell, value: 'Ngày sinh'},
                    {...headerCell, value: 'Giới tính'},
                    {...headerCell, value: 'Số CMND'},
                    {...headerCell, value: 'Ngày cấp'},
                    {...headerCell, value: 'Nơi cấp'},
                    {...headerCell, value: 'Địa chỉ'},
                    {...headerCell, value: 'ĐT di động'},
                    {...headerCell, value: 'ĐT cố định'},
                    {...headerCell, value: 'Email'},
                    {...headerCell, value: 'Tài khoản ngân hàng'},
                    {...headerCell, value: 'Tên ngân hàng'},
                    {...headerCell, value: 'Chi nhánh'}
                ],
                [
                    {value: 'NV-001', borderColor: '#000000'},
                    {value: 'Chu Dương Phương Nam', borderColor: '#000000'},
                    {value: 'Phòng Marketing', borderColor: '#000000'},
                    {value: 'Kiểm toán', borderColor: '#000000'},
                    {value: '30/05/2000', borderColor: '#000000'},
                    {value: 'Nữ', borderColor: '#000000'},
                    {value: '026300002417', borderColor: '#000000'},
                    {value: '10/10/2016', borderColor: '#000000'},
                    {value: 'Cục Cảnh sát', borderColor: '#000000'},
                    {value: 'Việt Xuân, Vĩnh Tường, Vĩnh Phúc', borderColor: '#000000'},
                    {value: '0869823803', borderColor: '#000000'},
                    {value: '1237829', borderColor: '#000000'},
                    {value: 'namkhmt@gmail.com', borderColor: '#000000'},
                    {value: '0869823803', borderColor: '#000000'},
                    {value: 'Ngân hàng Quân đội Việt Nam', borderColor: '#000000'},
                    {value: 'Ba Đình, Hà Nội', borderColor: '#000000'}
                ]
            ];
            const columns = [
                {width: 12},
                {width: 25},
                {width: 20},
                {width: 20},
                {width: 11},
                {width: 10},
                {width: 16},
                {width: 11},
                {width: 20},
                {width: 40},
                {width: 15},
                {width: 15},
                {width: 30},
                {width: 20},
                {width: 30},
                {width: 16}
            ];
            writeXlsxFile(data, {columns, fileName: 'import.xlsx'});
        }
    }
}
</script>

<style scoped>
    @import url('../../../css/common/dialog.css');

    .modal-content{
        top: calc(100vh/2);
        left: 50%;
        transform: translate(-50%,-50%);
    }

    .modal-body{
        flex-flow: column;
        align-items: flex-start !important;
    }
</style>