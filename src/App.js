// src/App.js
import React, { useState, useEffect } from 'react';
import axios from 'axios';

function App() {
  const [email, setEmail] = useState('');
  const [emails, setEmails] = useState([]);

  useEffect(() => {
    fetchEmails();
  }, []);

  const fetchEmails = async () => {
    const response = await axios.get('/api/emails');
    setEmails(response.data);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    await axios.post('/api/email', email);
    setEmail('');
    fetchEmails();
  };

  return (
    <div>
      <h1>Email Storage App</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder="Enter email"
          required
        />
        <button type="submit">Add Email</button>
      </form>
      <h2>Stored Emails:</h2>
      <ul>
        {emails.map((email, index) => (
          <li key={index}>{email}</li>
        ))}
      </ul>
    </div>
  );
}

export default App;