import React, { useEffect, useState } from 'react';
import { collection, onSnapshot } from 'firebase/firestore';
import { db } from '../../../firebase';
import User from './User';

const Users = () => {
  const [users, setUsers] = useState([]);
  const [search, setSearch] = useState('');

  useEffect(() => {
    getUsers();
  }, []);

  const getUsers = () => {
    const usersReference = collection(db, 'users');

    onSnapshot(usersReference, (querySnapshot) => {
      let tempUsers = [];

      querySnapshot.forEach((doc) => {
        tempUsers.push({
          name: doc.data().username,
          email: doc.data().userEmail,
          regId: doc.data().regId
        });
      });

      setUsers(tempUsers);
    });
  };

  return (
    <div>
      <div className="text-xl font-medium text-center">Users</div>
      <div className="flex-1 flex justify-center mt-5 w-100">
        <input
          required
          type="text"
          placeholder="Search..."
          className="border border-slate-300 rounded-md outline-none text-sm shadow-sm px-3 py-2 placeholder-slate-400 w-72 fixed"
          onChange={(e) => setSearch(e.target.value.toLowerCase())}
        />
      </div>
      <div className='flex flex-wrap mt-10 w-full min-w-[1000px]'>
        {users
          ?.filter(
            (user) =>
              user.name.toLowerCase().includes(search) ||
              user.email.toLowerCase().includes(search)
          )
          .map((user) => (
            <User key={user.email} user={user} />
          ))}
      </div>

    </div>
  );
};

export default Users;