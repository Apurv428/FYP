import React from 'react';
import { AiOutlineCheck } from 'react-icons/ai';
import { db } from '../../../firebase';
import { doc, updateDoc } from 'firebase/firestore';
import { ToastContainer, toast } from 'react-toastify';

const Order = ({ order }) => {
  const success = (message) => {
    toast.success(message, {
      position: 'top-right',
      autoClose: 2000,
      hideProgressBar: false,
      closeOnClick: true,
      pauseOnHover: true,
      draggable: true,
      progress: undefined,
      theme: 'dark',
    });
  };

  const handleServerd = () => {
    const orderReference = doc(db, 'Order', order.id);

    updateDoc(orderReference, {
      status: true,
    }).then(() => {
      success(`Order id ${order.id} moved to history`);
    });
  };

  return (
    <div className="w-[300px] shadow-lg bg-white p-6 rounded-lg m-3">
      <div className="text-sm font-semibold border-b-[2px] border-slate-200 pb-3">
        {order.email}
      </div>
      <div className="text-sm font-semibold mt-3">Order #{order.id}</div>
      <p>{order.timestamp}</p>

      <div className="w-full mt-4">
        <ul>
          {order.title.map((title, index) => (
            <li key={index}>
              {title} - {order.quantity[index]}
            </li>
          ))}
        </ul>
      </div>

      <div className="flex items-center justify-between mt-5">
        <div className="text-sm font-bold text-slate-900">
          Total: Rs. {order.price}
        </div>

        <button
          className="border-2 border-green-300 p-2 rounded-md"
          onClick={handleServerd}
        >
          <AiOutlineCheck color="#67de92" />
        </button>
      </div>

      <ToastContainer />
    </div>
  );
};

export default Order;
