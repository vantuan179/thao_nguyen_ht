-- Sample data (safe to re-run on every application start)

INSERT INTO users (username, password, email, full_name, role)
VALUES
    ('admin', 'admin123', 'admin@hotel.com', 'Administrator', 'ADMIN'),
    ('guest', 'guest123', 'guest@hotel.com', 'Guest User', 'USER')
ON CONFLICT (username) DO NOTHING;

INSERT INTO rooms (room_number, type, price_per_night, status, description)
VALUES
    ('101', 'SINGLE', 50.00, 'AVAILABLE', 'Standard single room'),
    ('102', 'DOUBLE', 75.00, 'AVAILABLE', 'Standard double room'),
    ('201', 'SUITE', 120.00, 'AVAILABLE', 'Junior suite'),
    ('202', 'DELUXE', 150.00, 'AVAILABLE', 'Deluxe double room'),
    ('301', 'SINGLE', 55.00, 'MAINTENANCE', 'Under maintenance')
ON CONFLICT (room_number) DO NOTHING;
