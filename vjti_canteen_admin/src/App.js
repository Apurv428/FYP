import React, { useState, useEffect } from 'react';
import { useDispatch } from 'react-redux'; 
import AddMenu from './components/admin/addmenu/AddMenu';
import History from './components/admin/history/History';
import Menus from './components/admin/menus/Menus';
import Orders from './components/admin/orders/Orders';
import Users from './components/admin/users/Users';
import Login from './components/Login';
import Navbar from './components/Navbar';
import Sidebar from './components/Sidebar';
import { setAdmin } from './redux/admin/adminSlice';
import { useAppSelector } from './redux/hook';
import MenusUnavailable from './components/admin/unavailable/Menus';

const App = () => {
  const dispatch = useDispatch();
  const admin = useAppSelector((state) => state.admin);

  const [active, setActive] = useState('Menus');

  useEffect(() => {
    const value = localStorage.getItem('canteenhubadmin');

    if (value) {
      const data = JSON.parse(value);

      if (data?.email) {
        dispatch(
          setAdmin({
            email: data.email,
            isSuperAdmin: data.isSuperAdmin,
          })
        );
      }
    }
  }, [dispatch]);

  return (
    <div className="max-h-scree">
      <Navbar />

      {admin.email.length > 0 ? (
        <div className="flex">
          <Sidebar active={active} setActive={setActive} />
          <div className="px-8 py-8 ml-[280px] mt-[80px]">
            {active === 'Menus' && <Menus />}
            {active === 'Add Menu' && <AddMenu />}
            {active === 'Unavailable Items' && <MenusUnavailable />}
            {active === 'Orders' && <Orders />}
            {active === 'History' && <History />}
            {active === 'All Users' && <Users />}
          </div>
        </div>
      ) : (
        <Login />
      )}
    </div>
  );
};

export default App;
