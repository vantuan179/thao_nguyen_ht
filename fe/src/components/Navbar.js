import React from 'react';
import { NavLink } from 'react-router-dom';

function Navbar() {
  return (
    <nav className="navbar">
      <div className="navbar-brand">🏨 Hotel Management</div>
      <ul className="navbar-links">
        <li>
          <NavLink to="/" end>Dashboard</NavLink>
        </li>
        <li>
          <NavLink to="/rooms">Rooms</NavLink>
        </li>
        <li>
          <NavLink to="/bookings">Bookings</NavLink>
        </li>
      </ul>
    </nav>
  );
}

export default Navbar;
