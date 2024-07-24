-- SCHEMA MANAGEMENT --

INSERT INTO organizations (name)
VALUES ('vitekorp');

INSERT INTO authorities (name, userid)
VALUES (
    'ADMIN',
    1
  );

INSERT INTO users (
    name,
    email,
    organizationid,
    password,
    enabled
  )
VALUES (
    'nuko',
    'vtsmolinski@outlook.com',
    metaorg,
    encode(pgp_sym_encrypt('linvic2024', 'linvic2024'), 'hex'),
    true
  );

select 
    pgp_sym_decrypt(decode(password, 'hex')::bytea, 'linvic2024') 
from users
where name = 'nuko'

INSERT INTO userauthorities (authorityid, userid)
VALUES (
    1,
    1
  );

alter table users
add constraint unique_useremail unique (email);

-- SELECTS --

select users.name as username,
    pgp_sym_decrypt(decode(users.password, 'hex')::bytea, 'linvic2024') as password,
    users.enabled as enabled,
    authorities.name as role,
    organizations.name as authority
from userauthorities 
    right join users
        on userauthorities.userid = users.id
    left join authorities
        on userauthorities.authorityid = authorities.id
    inner join organizations
        on users.organizationid = organizations.id
where users.name = 'nuko';

select 
    devices.name,
    devices.description,
    devices.ipaddress,
    devices.macaddress,
    devices.status,
    devices.gateway,
    devices.wgaddress,
    organizations.name as org
 from devices
    right join organizations
        on devices.organizationid = organizations.id
 where organizations.name = 'vitekorp'

select 
    users.name,
    users.lastname,
    users.email,
    users.enabled,
    organizations.name as org,
    pgp_sym_decrypt(decode(users.password, 'hex')::bytea, 'linvic2024') as password
 from users
    right join organizations
        on users.organizationid = organizations.id
 where organizations.name = 'vitekorp'

select 
    users.name as username,
    authorities.name as role
from userauthorities
    right join users
        on userauthorities.userid = users.id
    right join authorities
        on userauthorities.authorityid = authorities.id
where users.name = 'nukmaster';
