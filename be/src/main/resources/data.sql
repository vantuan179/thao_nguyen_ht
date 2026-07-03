-- Sample data for Hotel Management System

INSERT INTO users (username, email, password, full_name, phone, role) VALUES
('admin', 'admin@hotel.com', 'admin123', 'Administrator', '0900000000', 'ADMIN'),
('john_doe', 'john@example.com', 'password', 'John Doe', '0911111111', 'CUSTOMER'),
('jane_smith', 'jane@example.com', 'password', 'Jane Smith', '0922222222', 'CUSTOMER')
ON CONFLICT (username) DO NOTHING;

INSERT INTO rooms (room_number, type, price_per_night, capacity, description, status) VALUES
('101', 'Standard Single', 450000, 1, 'One single bed, city view', 'AVAILABLE'),
('102', 'Standard Double', 650000, 2, 'One double bed, city view', 'AVAILABLE'),
('201', 'Deluxe Double', 950000, 2, 'King bed, balcony', 'AVAILABLE'),
('301', 'Family Suite', 1500000, 4, 'Two bedrooms, living room', 'AVAILABLE'),
('302', 'Presidential Suite', 3200000, 2, 'Luxury suite, ocean view', 'AVAILABLE')
ON CONFLICT (room_number) DO NOTHING;
