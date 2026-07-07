angular.module('hotelApp', [])
    .controller('MainController', function($scope, $http) {

        // --- State ---
        $scope.currentTab = 'dashboard';
        $scope.loading = false;
        $scope.alert = { message: '', type: 'info' };

        $scope.rooms = [];
        $scope.bookings = [];
        $scope.users = [];

        $scope.showRoomForm = false;
        $scope.editingRoom = {};

        $scope.bookingForm = {
            userId: '',
            roomId: '',
            checkInDate: '',
            checkOutDate: ''
        };

        // --- Helpers ---
        $scope.setTab = function(tab) {
            $scope.currentTab = tab;
            $scope.closeAlert();
        };

        $scope.showAlert = function(message, type) {
            $scope.alert = { message: message, type: type || 'info' };
        };

        $scope.closeAlert = function() {
            $scope.alert = { message: '', type: 'info' };
        };

        $scope.badgeClass = function(status) {
            switch (status) {
                case 'AVAILABLE': return 'bg-success';
                case 'BOOKED': return 'bg-primary';
                case 'CHECKED_IN': return 'bg-info';
                case 'CHECKED_OUT': return 'bg-secondary';
                case 'MAINTENANCE': return 'bg-warning text-dark';
                case 'CANCELLED': return 'bg-danger';
                default: return 'bg-light text-dark';
            }
        };

        $scope.availableRoomsCount = function() {
            return $scope.rooms.filter(function(r) { return r.status === 'AVAILABLE'; }).length;
        };

        // --- API Calls ---
        function loadAll() {
            $scope.loading = true;
            Promise.all([
                $http.get('/api/rooms'),
                $http.get('/api/bookings'),
                $http.get('/api/users')
            ]).then(function(responses) {
                $scope.rooms = responses[0].data;
                $scope.bookings = responses[1].data;
                $scope.users = responses[2].data;
                $scope.loading = false;
            }).catch(function(error) {
                $scope.loading = false;
                $scope.showAlert('Không thể tải dữ liệu từ server. Vui lòng kiểm tra kết nối.', 'danger');
                console.error(error);
            }).finally(function() {
                $scope.$apply();
            });
        }

        // --- Rooms ---
        $scope.openRoomForm = function() {
            $scope.editingRoom = {
                roomNumber: '',
                type: 'SINGLE',
                pricePerNight: 0,
                status: 'AVAILABLE',
                description: ''
            };
            $scope.showRoomForm = true;
        };

        $scope.editRoom = function(room) {
            $scope.editingRoom = angular.copy(room);
            $scope.showRoomForm = true;
        };

        $scope.cancelRoomForm = function() {
            $scope.showRoomForm = false;
            $scope.editingRoom = {};
        };

        $scope.saveRoom = function() {
            var room = angular.copy($scope.editingRoom);
            var promise;

            if (room.id) {
                promise = $http.put('/api/rooms/' + room.id, room);
            } else {
                promise = $http.post('/api/rooms', room);
            }

            promise.then(function(response) {
                $scope.showAlert('Lưu phòng thành công!', 'success');
                $scope.showRoomForm = false;
                loadAll();
            }).catch(function(error) {
                $scope.showAlert('Lỗi khi lưu phòng: ' + (error.data?.error || error.statusText), 'danger');
                $scope.$apply();
            });
        };

        $scope.deleteRoom = function(id) {
            if (!confirm('Bạn có chắc muốn xóa phòng này?')) return;

            $http.delete('/api/rooms/' + id).then(function() {
                $scope.showAlert('Xóa phòng thành công!', 'success');
                loadAll();
            }).catch(function(error) {
                $scope.showAlert('Lỗi khi xóa phòng: ' + (error.data?.error || error.statusText), 'danger');
                $scope.$apply();
            });
        };

        // --- Bookings ---
        $scope.quickBook = function(room) {
            $scope.setTab('bookings');
            $scope.bookingForm = {
                userId: $scope.users.length > 0 ? String($scope.users[0].id) : '',
                roomId: String(room.id),
                checkInDate: '',
                checkOutDate: ''
            };
        };

        $scope.saveBooking = function() {
            var payload = {
                userId: parseInt($scope.bookingForm.userId),
                roomId: parseInt($scope.bookingForm.roomId),
                checkInDate: $scope.bookingForm.checkInDate,
                checkOutDate: $scope.bookingForm.checkOutDate
            };

            $http.post('/api/bookings', payload).then(function(response) {
                $scope.showAlert('Đặt phòng thành công! Tổng tiền: ' + response.data.totalPrice, 'success');
                $scope.bookingForm = { userId: '', roomId: '', checkInDate: '', checkOutDate: '' };
                loadAll();
            }).catch(function(error) {
                $scope.showAlert('Lỗi khi đặt phòng: ' + (error.data?.error || error.statusText), 'danger');
                $scope.$apply();
            });
        };

        $scope.updateBookingStatus = function(id, status) {
            $http.put('/api/bookings/' + id + '/status', { status: status }).then(function() {
                $scope.showAlert('Cập nhật trạng thái thành công!', 'success');
                loadAll();
            }).catch(function(error) {
                $scope.showAlert('Lỗi khi cập nhật trạng thái: ' + (error.data?.error || error.statusText), 'danger');
                $scope.$apply();
            });
        };

        $scope.deleteBooking = function(id) {
            if (!confirm('Bạn có chắc muốn xóa đặt phòng này?')) return;

            $http.delete('/api/bookings/' + id).then(function() {
                $scope.showAlert('Xóa đặt phòng thành công!', 'success');
                loadAll();
            }).catch(function(error) {
                $scope.showAlert('Lỗi khi xóa đặt phòng: ' + (error.data?.error || error.statusText), 'danger');
                $scope.$apply();
            });
        };

        // --- Init ---
        loadAll();
    });
