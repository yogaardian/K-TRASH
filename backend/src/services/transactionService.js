const db = require('../db');

const FEE_THRESHOLD = 50000;

function buildBalanceSnapshot(earnedBalance) {
  const earned_balance = Number(earnedBalance) || 0;
  const fee_reserved = Math.min(earned_balance, FEE_THRESHOLD);
  const spendable_balance = Math.max(earned_balance - FEE_THRESHOLD, 0);
  return { earned_balance, fee_reserved, spendable_balance };
}

async function getUserBalance(userId) {
  const [rows] = await db.query(
    'SELECT earned_balance, fee_reserved, spendable_balance FROM users WHERE id = ?',
    [userId],
  );

  if (rows.length === 0) {
    throw new Error('User not found');
  }

  return buildBalanceSnapshot(rows[0].earned_balance);
}

async function recordWasteSale(userId, amount, idempotencyKey = null) {
  const connection = await db.getConnection();
  try {
    await connection.beginTransaction();

    if (idempotencyKey) {
      const [existing] = await connection.query(
        'SELECT id FROM transactions WHERE idempotency_key = ? AND user_id = ? AND type = ?',
        [idempotencyKey, userId, 'waste_sale'],
      );
      if (existing.length > 0) {
        const transactionId = existing[0].id;
        await connection.rollback();
        const [balanceRows] = await db.query(
          'SELECT earned_balance, fee_reserved, spendable_balance FROM users WHERE id = ?',
          [userId],
        );
        return {
          transaction_id: transactionId,
          balance: buildBalanceSnapshot(balanceRows[0]?.earned_balance || 0),
          idempotent: true,
        };
      }
    }

    const [userRows] = await connection.query('SELECT id FROM users WHERE id = ? FOR UPDATE', [userId]);
    if (userRows.length === 0) {
      throw new Error('User not found');
    }

    await connection.query(
      `UPDATE users
       SET earned_balance = earned_balance + ?,
           fee_reserved = LEAST(earned_balance + ?, ?),
           spendable_balance = GREATEST(earned_balance + ? - ?, 0)
       WHERE id = ?`,
      [amount, amount, FEE_THRESHOLD, amount, FEE_THRESHOLD, userId],
    );

    const insertSql = idempotencyKey
      ? `INSERT INTO transactions (user_id, amount, type, description, idempotency_key, created_at)
         VALUES (?, ?, 'waste_sale', 'Waste sale income', ?, NOW())`
      : `INSERT INTO transactions (user_id, amount, type, description, created_at)
         VALUES (?, ?, 'waste_sale', 'Waste sale income', NOW())`;

    const insertParams = idempotencyKey
      ? [userId, amount, idempotencyKey]
      : [userId, amount];

    const [insertResult] = await connection.query(insertSql, insertParams);

    await connection.commit();

    const [balanceRows] = await db.query(
      'SELECT earned_balance, fee_reserved, spendable_balance FROM users WHERE id = ?',
      [userId],
    );

    return {
      transaction_id: insertResult.insertId,
      balance: buildBalanceSnapshot(balanceRows[0].earned_balance),
      idempotent: false,
    };
  } catch (err) {
    await connection.rollback();
    throw err;
  } finally {
    connection.release();
  }
}

module.exports = {
  getUserBalance,
  recordWasteSale,
};
