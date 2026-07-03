import React, { useEffect, useState } from 'react';
import { getAllRooms } from '../api/roomApi';
import { getAllBookings } from '../api/bookingApi';

function Dashboard() {
  const [stats, setStats] = useState({
    totalRooms: 0,
    availableRooms: 0,
    totalBookings: 0,
    confirmedBookings: 0,
    cancelledBookings: 0,
    totalRevenue: 0,
  });
  const [recentBookings, setRecentBookings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    const fetchDashboardData = async () => {
      try {
        setLoading(true);
        const [roomsResponse, bookingsResponse] = await Promise.all([
          getAllRooms(),
          getAllBookings(),
        ]);

        const rooms = roomsResponse.data.data || [];
        const bookings = bookingsResponse.data.data || [];

        const availableRooms = rooms.filter((r) => r.status === 'AVAILABLE').length;
        const confirmedBookings = bookings.filter((b) => b.status === 'CONFIRMED').length;
        const cancelledBookings = bookings.filter((b) => b.status === 'CANCELLED').length;
        const totalRevenue = bookings
          .filter((b) => b.status === 'CONFIRMED')
          .reduce((sum, b) => sum + Number(b.totalPrice || 0), 0);

        setStats({
          totalRooms: rooms.length,
          availableRooms,
          totalBookings: bookings.length,
          confirmedBookings,
          cancelledBookings,
          totalRevenue,
        });

        setRecentBookings(bookings.slice(0, 5));
        setError('');
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchDashboardData();
  }, []);

  return (
    <div>
      <h2>Dashboard</h2>

      {error && <div className="alert alert-error">{error}</div>}

      {loading ? (
        <p>Loading dashboard...</p>
      ) : (
        <>
          <div className="stats">
            <div className="stat-card">
              <h3>{stats.totalRooms}</h3>
              <p>Total Rooms</p>
            </div>
            <div className="stat-card">
              <h3>{stats.availableRooms}</h3>
              <p>Available Rooms</p>
            </div>
            <div className="stat-card">
              <h3>{stats.totalBookings}</h3>
              <p>Total Bookings</p>
            </div>
            <div className="stat-card">
              <h3>{stats.confirmedBookings}</h3>
              <p>Confirmed</p>
            </div>
            <div className="stat-card">
              <h3>{stats.cancelledBookings}</h3>
              <p>Cancelled</p>
            </div>
            <div className="stat-card">
              <h3>{stats.totalRevenue.toLocaleString('vi-VN')}</h3>
              <p>Revenue (VND)</p>
            </div>
          </div>

          <div className="card">
            <h3>Recent Bookings</h3>
            <table className="table">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Room</th>
                  <th>Guest</th>
                  <th>Check-in</th>
                  <th>Check-out</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
                {recentBookings.map((booking) => (
                  <tr key={booking.id}>
                    <td>{booking.id}</td>
                    <td>{booking.room?.roomNumber}</td>
                    <td>{booking.user?.fullName || booking.user?.username}</td>
                    <td>{booking.checkInDate}</td>
                    <td>{booking.checkOutDate}</td>
                    <td>
                      <span className={`status ${booking.status.toLowerCase()}`}>
                        {booking.status}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
            {recentBookings.length === 0 && <p>No recent bookings.</p>}
          </div>
        </>
      )}
    </div>
  );
}

export default Dashboard;
