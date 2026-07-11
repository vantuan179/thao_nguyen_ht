package com.mathkids.dto;

import lombok.Data;

@Data
public class ApiResponse<T> {
    private boolean success;
    private String message;
    private T data;

    // 1. TỰ VIẾT TAY CÁC CONSTRUCTOR ĐỂ ĐẢM BẢO CHẮC CHẮN KHÔNG LỖI BÊN DỊCH
    public ApiResponse() {
    }

    public ApiResponse(boolean success, String message, T data) {
        this.success = success;
        this.message = message;
        this.data = data;
    }

    // 2. Định nghĩa hàm khởi tạo Builder static
    public static <T> ApiResponseBuilder<T> builder() {
        return new ApiResponseBuilder<>();
    }

    // 3. Các hàm tiện ích static giữ nguyên logic của bạn
    public static <T> ApiResponse<T> success(T data) {
        return ApiResponse.<T>builder().success(true).data(data).build();
    }

    public static <T> ApiResponse<T> success(String message, T data) {
        return ApiResponse.<T>builder().success(true).message(message).data(data).build();
    }

    public static <T> ApiResponse<T> error(String message) {
        return ApiResponse.<T>builder().success(false).message(message).build();
    }

    // 4. Lớp Builder thủ công chạy độc lập
    public static class ApiResponseBuilder<T> {
        private boolean success;
        private String message;
        private T data;

        public ApiResponseBuilder<T> success(boolean success) {
            this.success = success;
            return this;
        }

        public ApiResponseBuilder<T> message(String message) {
            this.message = message;
            return this;
        }

        public ApiResponseBuilder<T> data(T data) {
            this.data = data;
            return this;
        }

        public ApiResponse<T> build() {
            return new ApiResponse<>(this.success, this.message, this.data);
        }
    }
}