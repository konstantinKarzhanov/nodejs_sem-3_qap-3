SELECT hotel.hotel_name,
  hotel.hotel_website,
  guest.guest_fname,
  guest.guest_lname,
  address.address_street AS street,
  address.address_city AS city,
  guest.guest_email,
  guest.guest_phone,
  reservation.reservation_date,
  room.room_type,
  room.room_description,
  reservation_detail.check_in,
  reservation_detail.check_out,
  reservation_detail.night_count,
  reservation.subtotal_cost,
  reservation.discount,
  reservation.tax_amount,
  reservation.total_cost,
  reservation.payment_method
  FROM guest
    JOIN address USING (address_id)
    JOIN reservation USING (guest_id)
    JOIN hotel USING (hotel_id)
    JOIN reservation_detail USING (reservation_id)
    JOIN room USING (room_id);

-- --------------------------------------------------------------------------
-- test view which generates "reservation details" using data from each table
-- --------------------------------------------------------------------------
SELECT * FROM view_reservation_details;