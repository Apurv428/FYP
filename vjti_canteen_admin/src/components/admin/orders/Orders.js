import React, { useEffect, useState } from 'react';
import { collection, onSnapshot, query, where } from 'firebase/firestore';
import { db } from '../../../firebase';
import Order from './Order';

const Orders = () => {
  const [orders, setOrders] = useState([]);
  const [orderIdFilter, setOrderIdFilter] = useState('');
  const [sortBy, setSortBy] = useState('ascending');

  useEffect(() => {
    getOrders();
  }, [orderIdFilter, sortBy]);

  const getOrders = async () => {
    let ordersReference = collection(db, 'Order');

    if (orderIdFilter) {
      const orderId = parseInt(orderIdFilter);
      ordersReference = query(
        ordersReference,
        where('orderID', '==', orderId)
      );
    }

    ordersReference = query(
      ordersReference,
      where('status', '==', false)
    );

    onSnapshot(ordersReference, (querySnapshot) => {
      let tempOrders = [];

      querySnapshot.forEach((doc) => {
        const data = doc.data();
        tempOrders.push({
          id: doc.id,
          email: data.email,
          orderId: data.orderID,
          title: data.title,
          quantity: data.quantity,
          served: data.status,
          price: data.price,
        });
      });

      // Sorting based on the selected option
      if (sortBy === 'ascending') {
        tempOrders.sort((a, b) => (a.orderId > b.orderId ? 1 : -1));
      } else {
        tempOrders.sort((a, b) => (a.orderId < b.orderId ? 1 : -1));
      }

      setOrders(tempOrders);
    });
  };

  return (
    <div>
      <div className="text-xl font-medium text-center">Orders</div>
      <div className="flex justify-center mt-3">
        <input
          type="text"
          placeholder="Order ID"
          className="px-3 py-1 mr-2 border border-gray-300 rounded"
          value={orderIdFilter}
          onChange={(e) => setOrderIdFilter(e.target.value)}
        />
        <select
          value={sortBy}
          onChange={(e) => setSortBy(e.target.value)}
          className="px-3 py-1 border border-gray-300 rounded"
        >
          <option value="ascending">Ascending</option>
          <option value="descending">Descending</option>
        </select>
      </div>
      <div className="flex flex-wrap mt-3">
        {orders.length>0? orders.map((order) => (
          <Order key={order.id} order={order} />
        )):<p>No items in order</p>}
      </div>
    </div>
  );
};

export default Orders;