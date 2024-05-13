import React, { useEffect, useState } from 'react';
import { collection, onSnapshot, query, where } from 'firebase/firestore';
import { db } from '../../../firebase';
import HistoryItem from './HistoryItem';

const History = () => {
  const [history, setHistory] = useState([]);
  const [orderIdFilter, setOrderIdFilter] = useState('');
  const [sortBy, setSortBy] = useState('ascending');

  useEffect(() => {
    getHistory();
  }, [orderIdFilter, sortBy]);

  const getHistory = async () => {
    let historyReference = collection(db, 'Order');

    if (orderIdFilter) {
      const orderId = parseInt(orderIdFilter);
      historyReference = query(
        historyReference,
        where('orderID', '==', orderId)
      );
    }

    historyReference = query(
      historyReference,
      where('status', '==', true)
    );

    onSnapshot(historyReference, (querySnapshot) => {
      let temphistory = [];

      querySnapshot.forEach((doc) => {
        const data = doc.data();
        temphistory.push({
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
        temphistory.sort((a, b) => (a.orderId > b.orderId ? 1 : -1));
      } else {
        temphistory.sort((a, b) => (a.orderId < b.orderId ? 1 : -1));
      }

      setHistory(temphistory);
    });
  };

  return (
    <div>
      <div className="text-xl font-medium text-center">History</div>
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
        {history.length>0? history.map((order) => (
          <HistoryItem key={order.id} order={order} />
        )):<p>No items in history</p>}
      </div>
    </div>
  );
};

export default History;