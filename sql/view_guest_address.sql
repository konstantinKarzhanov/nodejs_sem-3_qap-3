 SELECT guest.guest_id,
    guest.guest_fname,
    guest.guest_lname,
    guest.guest_dob,
    guest.guest_email,
    guest.guest_phone,
    address.address_street AS street,
    address.address_city AS city,
    address.address_province AS province,
    address.address_postal_code AS postal_code
   FROM guest
     JOIN address USING (address_id);