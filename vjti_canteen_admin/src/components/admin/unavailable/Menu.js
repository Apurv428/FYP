import { LazyLoadImage } from 'react-lazy-load-image-component';
import { updateDoc, doc } from 'firebase/firestore';
import { db } from '../../../firebase';

const MenuUnavailable = ({ menu }) => {
  const handleAvailability = () => {
    const menusReference = doc(db, 'Food',menu.id);

    updateDoc(menusReference, {
      available: true,
    })
  };

  return (
    <div className="shadow-xl p-5 w-50 rounded-lg m-3 relative">
      <LazyLoadImage
        src={menu.foodimage}
        alt={`${menu.foodtitle}_image`}
        className="mb-3 rounded-lg w-[200px] h-[133.2px] object-cover"
        width={200}
        height={133.2}
      />
      <div className="flex justify-between items-center">
        <div>
          <div className="text-sm text-slate-700 font-medium">{menu.foodtitle}</div>
          <p className="text-sm text-slate-600 font-semibold">Rs. {menu.foodprice}</p>
        </div>
      </div>
      <div className="flex justify-center items-center mt-2">
      <button className="bg-green-500 hover:bg-green-700 text-white font-bold py-1 px-3 rounded text-sm" onClick={handleAvailability}>
        Available
      </button>
      </div>
    </div>
  );
};

export default MenuUnavailable;
