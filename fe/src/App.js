import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Navbar from './components/Navbar';
import RoomList from './components/RoomList';
import BookingForm from './components/BookingForm';
import Dashboard from './components/Dashboard';
import './App.css';

function App() {
  return (
    <div className="app">
      <Navbar />
      <main className="container">
        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/rooms" element={<RoomList />} />
          <Route path="/bookings" element={<BookingForm />} />
        </Routes>
      </main>
    </div>
  );
}

export default App;
