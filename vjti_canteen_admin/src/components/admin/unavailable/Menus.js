import { useEffect, useState } from 'react';
import { db } from '../../../firebase';
import { collection, onSnapshot, query, where } from 'firebase/firestore';
import MenuUnavailable from './Menu';

const MenusUnavailable = () => {
  const [menus, setMenus] = useState([]);
  const [search, setSearch] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('All');

  useEffect(() => {
    getMenus();
  }, []);

  const getMenus = () => {
    let menusReference = collection(db, 'Food');
    menusReference = query(
      menusReference,
      where('available', '==', false)
    );

    console.log(menusReference)

    onSnapshot(menusReference, (querySnapshot) => {
      let tempMenus = [];

      querySnapshot.forEach((doc) => {
        tempMenus.push({
          id: doc.id,
          foodimage: doc.data().foodimage,
          foodtitle: doc.data().foodtitle,
          foodprice: doc.data().foodprice,
          foodcategory: doc.data().foodcategory,
        });
      });

      setMenus(tempMenus);
    });
  };

  const filterMenusByCategory = (menu) => {
    if (selectedCategory === 'All') {
      return true;
    } else {
      return menu.foodcategory === selectedCategory;
    }
  };

  return (
    <div>
      <div className="mt-5 mx-auto">
        <div className="text-xl font-medium text-center text-uppercase">Unavailable Menu Items</div>
        <div className="flex justify-center my-5">
          <input
            required
            type="text"
            placeholder="Search..."
            className="border border-slate-300 rounded-md outline-none text-sm shadow-sm px-3 py-2 placeholder-slate-400 w-72"
            onChange={(e) => setSearch(e.target.value)}
          />
          &nbsp;&nbsp;
          <select
            className="border border-slate-300 rounded-md outline-none text-sm shadow-sm px-3 py-2 placeholder-slate-400 right-5"
            value={selectedCategory}
            onChange={(e) => setSelectedCategory(e.target.value)}
          >
            <option value="All">All</option>
            <option value="Snacks">Snacks</option>
            <option value="Breakfast">Breakfast</option>
            <option value="Lunch">Lunch</option>
            <option value="Beverages">Beverages</option>
            <option value="Confectionery">Confectionery</option>
          </select>

        </div>
      </div>
      <div className="flex flex-wrap mt-5">
        {menus
          .filter((menu) => menu.foodtitle.toLocaleLowerCase().includes(search.toLowerCase()))
          .filter(filterMenusByCategory)
          .map((menu) => (
            <MenuUnavailable key={menu.id} menu={menu} />
          ))}
      </div>
    </div>
  );
};

export default MenusUnavailable;
