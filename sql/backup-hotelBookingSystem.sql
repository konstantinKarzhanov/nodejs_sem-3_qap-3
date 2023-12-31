PGDMP  .                    {            hotelBookingSystem    16rc1    16rc1 8    [           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            \           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ]           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ^           1262    19008    hotelBookingSystem    DATABASE     v   CREATE DATABASE "hotelBookingSystem" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
 $   DROP DATABASE "hotelBookingSystem";
                postgres    false            �            1259    19009    address    TABLE     Q  CREATE TABLE public.address (
    address_id integer NOT NULL,
    address_street character varying(50) NOT NULL,
    address_city character varying(20) NOT NULL,
    address_province character varying(2) NOT NULL,
    address_postal_code character varying(6) NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.address;
       public         heap    postgres    false            �            1259    19013    address_id_seq    SEQUENCE     �   CREATE SEQUENCE public.address_id_seq
    AS integer
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.address_id_seq;
       public          postgres    false    215            _           0    0    address_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.address_id_seq OWNED BY public.address.address_id;
          public          postgres    false    216            �            1259    19014    guest    TABLE     �  CREATE TABLE public.guest (
    guest_id integer NOT NULL,
    address_id integer NOT NULL,
    guest_fname character varying(30) NOT NULL,
    guest_lname character varying(30) NOT NULL,
    guest_dob character varying(10) NOT NULL,
    guest_email character varying(50) NOT NULL,
    guest_phone character varying(10) NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.guest;
       public         heap    postgres    false            �            1259    19018    guest_id_seq    SEQUENCE     �   CREATE SEQUENCE public.guest_id_seq
    AS integer
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.guest_id_seq;
       public          postgres    false    217            `           0    0    guest_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.guest_id_seq OWNED BY public.guest.guest_id;
          public          postgres    false    218            �            1259    19019    hotel    TABLE     `  CREATE TABLE public.hotel (
    hotel_id integer NOT NULL,
    address_id integer NOT NULL,
    hotel_name character varying(50) NOT NULL,
    hotel_website character varying(50) NOT NULL,
    hotel_email character varying(50) NOT NULL,
    hotel_phone character varying(10) NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.hotel;
       public         heap    postgres    false            �            1259    19023    hotel_id_seq    SEQUENCE     �   CREATE SEQUENCE public.hotel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.hotel_id_seq;
       public          postgres    false    219            a           0    0    hotel_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.hotel_id_seq OWNED BY public.hotel.hotel_id;
          public          postgres    false    220            �            1259    19024    reservation    TABLE     �  CREATE TABLE public.reservation (
    reservation_id integer NOT NULL,
    hotel_id integer DEFAULT 1 NOT NULL,
    guest_id integer,
    reservation_date date DEFAULT CURRENT_DATE NOT NULL,
    subtotal_cost real NOT NULL,
    discount real NOT NULL,
    tax_amount real NOT NULL,
    total_cost real NOT NULL,
    payment_method character varying(20) NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.reservation;
       public         heap    postgres    false            �            1259    19029    reservation_detail    TABLE     �   CREATE TABLE public.reservation_detail (
    reservation_id integer NOT NULL,
    room_id integer NOT NULL,
    check_in date NOT NULL,
    check_out date NOT NULL,
    night_count integer NOT NULL,
    detail_cost real NOT NULL
);
 &   DROP TABLE public.reservation_detail;
       public         heap    postgres    false            �            1259    19032    reservation_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reservation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.reservation_id_seq;
       public          postgres    false    221            b           0    0    reservation_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.reservation_id_seq OWNED BY public.reservation.reservation_id;
          public          postgres    false    223            �            1259    19033    room    TABLE     �  CREATE TABLE public.room (
    room_id integer NOT NULL,
    hotel_id integer NOT NULL,
    room_type character varying(50) NOT NULL,
    room_capacity integer NOT NULL,
    room_description character varying(300) NOT NULL,
    room_cost_night real NOT NULL,
    room_status character varying(10) DEFAULT 'Available'::character varying NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.room;
       public         heap    postgres    false            �            1259    19038    room_id_seq    SEQUENCE     �   CREATE SEQUENCE public.room_id_seq
    AS integer
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.room_id_seq;
       public          postgres    false    224            c           0    0    room_id_seq    SEQUENCE OWNED BY     @   ALTER SEQUENCE public.room_id_seq OWNED BY public.room.room_id;
          public          postgres    false    225            �            1259    19039    view_guest_address    VIEW     �  CREATE VIEW public.view_guest_address AS
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
   FROM (public.guest
     JOIN public.address USING (address_id));
 %   DROP VIEW public.view_guest_address;
       public          postgres    false    215    215    215    217    215    217    217    217    217    217    217    215            �            1259    19043    view_reservation_details    VIEW     Q  CREATE VIEW public.view_reservation_details AS
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
   FROM (((((public.guest
     JOIN public.address USING (address_id))
     JOIN public.reservation USING (guest_id))
     JOIN public.hotel USING (hotel_id))
     JOIN public.reservation_detail USING (reservation_id))
     JOIN public.room USING (room_id));
 +   DROP VIEW public.view_reservation_details;
       public          postgres    false    221    221    221    221    221    221    219    219    217    217    217    217    217    217    215    215    215    219    224    224    224    222    222    222    222    222    221    221    221            �           2604    19048    address address_id    DEFAULT     p   ALTER TABLE ONLY public.address ALTER COLUMN address_id SET DEFAULT nextval('public.address_id_seq'::regclass);
 A   ALTER TABLE public.address ALTER COLUMN address_id DROP DEFAULT;
       public          postgres    false    216    215            �           2604    19049    guest guest_id    DEFAULT     j   ALTER TABLE ONLY public.guest ALTER COLUMN guest_id SET DEFAULT nextval('public.guest_id_seq'::regclass);
 =   ALTER TABLE public.guest ALTER COLUMN guest_id DROP DEFAULT;
       public          postgres    false    218    217            �           2604    19050    hotel hotel_id    DEFAULT     j   ALTER TABLE ONLY public.hotel ALTER COLUMN hotel_id SET DEFAULT nextval('public.hotel_id_seq'::regclass);
 =   ALTER TABLE public.hotel ALTER COLUMN hotel_id DROP DEFAULT;
       public          postgres    false    220    219            �           2604    19051    reservation reservation_id    DEFAULT     |   ALTER TABLE ONLY public.reservation ALTER COLUMN reservation_id SET DEFAULT nextval('public.reservation_id_seq'::regclass);
 I   ALTER TABLE public.reservation ALTER COLUMN reservation_id DROP DEFAULT;
       public          postgres    false    223    221            �           2604    19052    room room_id    DEFAULT     g   ALTER TABLE ONLY public.room ALTER COLUMN room_id SET DEFAULT nextval('public.room_id_seq'::regclass);
 ;   ALTER TABLE public.room ALTER COLUMN room_id DROP DEFAULT;
       public          postgres    false    225    224            N          0    19009    address 
   TABLE DATA              COPY public.address (address_id, address_street, address_city, address_province, address_postal_code, last_update) FROM stdin;
    public          postgres    false    215   �K       P          0    19014    guest 
   TABLE DATA           �   COPY public.guest (guest_id, address_id, guest_fname, guest_lname, guest_dob, guest_email, guest_phone, last_update) FROM stdin;
    public          postgres    false    217   ]P       R          0    19019    hotel 
   TABLE DATA           w   COPY public.hotel (hotel_id, address_id, hotel_name, hotel_website, hotel_email, hotel_phone, last_update) FROM stdin;
    public          postgres    false    219   VX       T          0    19024    reservation 
   TABLE DATA           �   COPY public.reservation (reservation_id, hotel_id, guest_id, reservation_date, subtotal_cost, discount, tax_amount, total_cost, payment_method, last_update) FROM stdin;
    public          postgres    false    221   �X       U          0    19029    reservation_detail 
   TABLE DATA           t   COPY public.reservation_detail (reservation_id, room_id, check_in, check_out, night_count, detail_cost) FROM stdin;
    public          postgres    false    222   �Y       W          0    19033    room 
   TABLE DATA           �   COPY public.room (room_id, hotel_id, room_type, room_capacity, room_description, room_cost_night, room_status, last_update) FROM stdin;
    public          postgres    false    224   fZ       d           0    0    address_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.address_id_seq', 52, true);
          public          postgres    false    216            e           0    0    guest_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.guest_id_seq', 50, true);
          public          postgres    false    218            f           0    0    hotel_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.hotel_id_seq', 1, true);
          public          postgres    false    220            g           0    0    reservation_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.reservation_id_seq', 10, true);
          public          postgres    false    223            h           0    0    room_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.room_id_seq', 10, true);
          public          postgres    false    225            �           2606    19054    address address_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);
 >   ALTER TABLE ONLY public.address DROP CONSTRAINT address_pkey;
       public            postgres    false    215            �           2606    19056    guest guest_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.guest
    ADD CONSTRAINT guest_pkey PRIMARY KEY (guest_id);
 :   ALTER TABLE ONLY public.guest DROP CONSTRAINT guest_pkey;
       public            postgres    false    217            �           2606    19058    hotel hotel_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (hotel_id);
 :   ALTER TABLE ONLY public.hotel DROP CONSTRAINT hotel_pkey;
       public            postgres    false    219            �           2606    19060 *   reservation_detail reservation_detail_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.reservation_detail
    ADD CONSTRAINT reservation_detail_pkey PRIMARY KEY (reservation_id, room_id);
 T   ALTER TABLE ONLY public.reservation_detail DROP CONSTRAINT reservation_detail_pkey;
       public            postgres    false    222    222            �           2606    19062    reservation reservation_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (reservation_id);
 F   ALTER TABLE ONLY public.reservation DROP CONSTRAINT reservation_pkey;
       public            postgres    false    221            �           2606    19064    room room_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (room_id);
 8   ALTER TABLE ONLY public.room DROP CONSTRAINT room_pkey;
       public            postgres    false    224            �           2606    19066    address uq_address 
   CONSTRAINT     w   ALTER TABLE ONLY public.address
    ADD CONSTRAINT uq_address UNIQUE (address_street, address_city, address_province);
 <   ALTER TABLE ONLY public.address DROP CONSTRAINT uq_address;
       public            postgres    false    215    215    215            �           2606    19068 #   reservation_detail uq_composite_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.reservation_detail
    ADD CONSTRAINT uq_composite_key UNIQUE (reservation_id, room_id);
 M   ALTER TABLE ONLY public.reservation_detail DROP CONSTRAINT uq_composite_key;
       public            postgres    false    222    222            �           2606    19070    guest uq_email 
   CONSTRAINT     P   ALTER TABLE ONLY public.guest
    ADD CONSTRAINT uq_email UNIQUE (guest_email);
 8   ALTER TABLE ONLY public.guest DROP CONSTRAINT uq_email;
       public            postgres    false    217            �           2606    19072    guest uq_guest 
   CONSTRAINT     h   ALTER TABLE ONLY public.guest
    ADD CONSTRAINT uq_guest UNIQUE (guest_fname, guest_lname, guest_dob);
 8   ALTER TABLE ONLY public.guest DROP CONSTRAINT uq_guest;
       public            postgres    false    217    217    217            �           2606    19074    address uq_postal_code 
   CONSTRAINT     `   ALTER TABLE ONLY public.address
    ADD CONSTRAINT uq_postal_code UNIQUE (address_postal_code);
 @   ALTER TABLE ONLY public.address DROP CONSTRAINT uq_postal_code;
       public            postgres    false    215            �           2606    19075    guest guest_address_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.guest
    ADD CONSTRAINT guest_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id) NOT VALID;
 E   ALTER TABLE ONLY public.guest DROP CONSTRAINT guest_address_id_fkey;
       public          postgres    false    3489    215    217            �           2606    19080    hotel hotel_address_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id) NOT VALID;
 E   ALTER TABLE ONLY public.hotel DROP CONSTRAINT hotel_address_id_fkey;
       public          postgres    false    3489    219    215            �           2606    19085 9   reservation_detail reservation_detail_reservation_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reservation_detail
    ADD CONSTRAINT reservation_detail_reservation_id_fkey FOREIGN KEY (reservation_id) REFERENCES public.reservation(reservation_id) NOT VALID;
 c   ALTER TABLE ONLY public.reservation_detail DROP CONSTRAINT reservation_detail_reservation_id_fkey;
       public          postgres    false    222    3503    221            �           2606    19090 2   reservation_detail reservation_detail_room_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reservation_detail
    ADD CONSTRAINT reservation_detail_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.room(room_id);
 \   ALTER TABLE ONLY public.reservation_detail DROP CONSTRAINT reservation_detail_room_id_fkey;
       public          postgres    false    222    3509    224            �           2606    19095 %   reservation reservation_guest_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_guest_id_fkey FOREIGN KEY (guest_id) REFERENCES public.guest(guest_id) NOT VALID;
 O   ALTER TABLE ONLY public.reservation DROP CONSTRAINT reservation_guest_id_fkey;
       public          postgres    false    221    3495    217            �           2606    19100 %   reservation reservation_hotel_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(hotel_id) NOT VALID;
 O   ALTER TABLE ONLY public.reservation DROP CONSTRAINT reservation_hotel_id_fkey;
       public          postgres    false    221    219    3501            �           2606    19105    room room_hotel_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotel(hotel_id);
 A   ALTER TABLE ONLY public.room DROP CONSTRAINT room_hotel_id_fkey;
       public          postgres    false    219    3501    224            N   o  x���MR�H���)����J��$����-nG̦lv�%	��=�bS*ɴL/�a^d���e� �̚��LXi���`U�"�
���̍HD�ڔ]rM��[��R�����k��2����z�=��W��x�+�W� N����~���B+�jw����Lס��G#���M��̅5幀�g��!�aE���Z�|�d��#�U��xcȄ,ܙ����fV"�\�-�O�������۱�gU��]�W?j�;+��{cː<8��pm׺��ue-�\>��bX���!x�g�e�omF<����S�و���"����&w���|�U��I'��s6qB;h}�N�BIn��d�p�P�� c͈�d��I�{,P��3 Ƙi��[���Q�P�O�-t�k�� sn,ql�y����3oI�k\�o%̧��2�58�'�#WYQU�*�rX !�.!���u��Sb/Tӫ�1X�F� <�h~�壀�
~��.�MB��3��8e%��*lV�!�;C�����³ZV0�~ڑ=�*�04�tŵ����`�&�� ��x&�R���`�k��l�`�2�a/��rw�ɵo�|C֘rCbCs��DV����>hf�i T\��E���ڗE+�̈S���|ΜZ)�Z̖���+~z>焷"Cy40�����n��k��>�.t��ӑ�L)lɦf���y���uS�X'� ��L���z�r�gYi�:CXè�Gp���y����Mb̀��7�n��|,T0MQ���^�H�i��� zzeb�����v��a��g<^�o׫�x�9����$A,_��>^�B��K�*��W��Fd��M
;��C��M�+�*4G]����,44��vq[L�)�m�6,�Ϸ�����b��.g��c�C>o㋃�&��j`�<jS�?�:Ĩ�^
^$�5��F�I�1���y��~[��}`�8:���Ԗ�O܈�1{�&9�5�]���l�5���]�b���+3�J�;	���Q��*�'a���p_<BC_�kCy�6L�����&�5k\����������d:\���^/5W�	�|*j�Rv�����?7WWW��k_J      P   �  x��XM��8=W~En{�!~��rR'��1����&@�Z�m�%�C�v�_���:��"�N�rQdU��(F�>�w�v��{;Dw%Vj�+�h������4.��T���"/$�<���-��{�Ě^���;������ںH�r�\? �a+���n�X���vH_����3:+��	��6н��wH��UfV\R�!^�B�5n�2Y�5�R�_��$�K<Վ>�Kʫ��9[w���^�)v��Ƿ��)��u�rz�����9�t&9[e��)�#$�[ݹa��
�7�5W�άH�]Ӡ���|��Z�'{�����apq�\��Zj]p�Ղ��4=��{�Х5��KzlgP�m�>�q�Y.���^Đ�'wEC�]�oN1��1�>4E���gt	�`볋���Dkt3q�M���,�RA�uu=vT}F�T� Sd[[퀙���l7��(�Jgj�vXF����]�?���>�l�M���Q�OPQV{�ٔ]uT�L1#�b�0���-&�~(r�
F�X�����e?���w�L�eE�gZ-�ⷳw����f���MY�6�1�3�	�$���o�@��n��:Mq�S�LXU�~���ȴV*SKJ�$!��ӗ��ل�Rk��'�f�N}�W����4B��%��	����l��G�rM}!Wn�=���,D�L�-!����Ɓ��?���4+�;�ж<u�&��ۈ�T\�|Y�hB|���]Cw�+�4sk�+��ΎЮ���8��F��ЪX����G��9���Q��?�����8��Ʌ2Ldl���F_]��P����Ƅ ��y����/��\h!t=��=�&@`@��sy�~�A�����G4Q�3Gq�#F�������a�.�z�Q�@��Oء����i��km
��,�mrz
7������?�Q�����q�6�s�S�V�.S�
�X]��l7�W?쓚�9�Y�%� ��.?�<�ꀆ�ì�ԭ ��b�bض���x�1�s7�d�lL��8a]����Uzj.)$���^�LN�{;��Shp~}*~1�6�}�� ���l:4��Di�/X ��[p�\ٶ�9y&U����|R����0��ɱCM�.�\*�C�!t�Q�
6�v�V��]��lt��V2��KV�]]C>�6T�c�m����]��8��,3�&Q�7ߜ��'L�$>b�C�8B}Y٭;b�j�xΥ�$Hd�x
��Ou<�����cB���N�kW�Pe� ��,�Vp4�aP����Sr~�R������Fi|܃�4�Nx�*�`*�Z���!�ݔOE��	;���͵�S�2c0{�/1fv[$�Ǟ�j7�W�G������忩�y�A������\�z����5��g�"o���l�����Ϙ~&�����x����iw�#嚱��z�����0.�ab��I]��8�È%�q7����}&E��+K�|�n�6��lr.R�b�9����%G�����t{C�)�l�XV�0UCL��e�@��W��|�(�C�	g�
�M&�=��vB.r�kİO�|U�|I��-��ڴ0�8�龕�	2n0^v;�K�관=dF�G�����v�Y$(�˄����2Q^���y������ >y�Ԑ7z�C2���e�=��m��2Yv������h����e8.QtjjK��n�����fi�I��#X��_~\�Xn��l�ۑ͍�t� ���͐�9�bF����� Se����f��Y-Y�j�]���yX��;m��T��r��M��6:wq�i.g�A��ɓ9\�ﶺ��p���s3�l4lf�\��q˰~9��C_��f�HE�{�G:�7�W���&O[��m�0+ʋ�*7�G���Uj�I�ác��?D���EC?B̖;kCf¡.L��'!���)$�����0��턱��Y6���UK��� ��5z��#�ۻ�7E�qYUV}:?�88P�SF/�D�(��ֶ�Z��s��H:G��p�5,�og�U��Y��%
����7o�xt�      R   b   x�m�;� �z9��v� ����7��_L��p�����MyMz�%�1��������d��vZrN��w �YD���M*o��W�I�f��z �sC      T   �   x���Mj�@F��)r��3���5�	$�n�ޟ~jM���X2�xz#YH�(����3^�FM�������^��"���"��.�{�h�m1�4I�c�@b����>��� �@�0���<�@�g:%��lL�I:��TjGv�crhO��1��!�;S(����Tu�虎�X��	�J�ySE���m7�S~̱3�B�3�0ė�H�1z�w�20�A=ƌxJN8�aމh`�g��z��a�k���F��\      U   �   x�M���0�`/� �u����05�C�vVApz-�/l�p���#GaM�h��s��A���9vzbX��NJ���(G�t�啸"8m`���A�+�����2q/�����!ˤ=}�"��y��#kT|?fv��6�      W   �  x����r�0Ek�+�0����Y�s�fk���!���g�N��J��=s/GJ(��`
p�Hų=��Y[�/�	�#��v/�eN��ͱ�d0*I�c�a�Q�I�EJE�R��&�6�u��U�N#�d�2�u{B1�r�m#��<��jG��[�Ǽ4�Y��"���u�����3I|�S��*�E������x�k��u~Xs��'F;�p"S��g[�L{��t/��h�M��ۄܛ����p�� ��^O���:�|:�R*[�3*4�	���(�I�L�j,��;펜 j��2`1�Zr�hF���W��x>P~�D�5��;M�P8d�0��^���(�����I��j+��5:np�S�$�b�N��ɟ[��3��#�i�#��f���19     