const db = require('../db');

exports.updateLocation = async (req, res) => {
  const { driver_id, order_id, lat, lng } = req.body;

  const [order] = await db.query(
    'SELECT status FROM orders WHERE id = ?',
    [order_id]
  );

  if (!order.length || !['assigned', 'on_the_way'].includes(order[0].status)) {
    return res.json({ message: 'Order belum aktif' });
  }

  await db.query(`
    INSERT INTO driver_locations (driver_id, order_id, lat, lng)
    VALUES (?, ?, ?, ?)
  `, [driver_id, order_id, lat, lng]);

  res.json({ message: 'Lokasi tersimpan' });
};

exports.acceptOrder = async (req, res) => {
  const { driver_id } = req.body;
  const orderId = req.params.id;

  const [result] = await db.query(`
    UPDATE orders
    SET driver_id = ?, status = 'assigned'
    WHERE id = ? AND status = 'pending'
  `, [driver_id, orderId]);

  if (result.affectedRows === 0) {
    return res.status(400).json({ message: 'Order sudah diambil' });
  }

  res.json({ message: 'Berhasil ambil order' });
};