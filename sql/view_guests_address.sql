SELECT 
	guest_id,
	guest_fname,
	guest_lname,
	guest_dob,
	guest_email,
	guest_phone,
	street,
	city,
	province,
	postal_code
FROM guest
JOIN "address" USING (address_id);