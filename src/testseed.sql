INSERT INTO organizations (name)
VALUES ('vitekorp');

INSERT INTO authorities (id, name)
VALUES (
        1,
    'ADMIN'
  );

INSERT INTO authorities (id,name)
VALUES (
    2,
    'MANAGER'
  );

INSERT INTO authorities (id, name)
VALUES (
    3,
    'CONTRIBUTOR'
  );

INSERT INTO authorities (id, name)
VALUES (
    4,
    'GUEST'
  );

INSERT INTO users (
    id,
    name,
    email,
    organizationid,
    password,
    enabled
  )
VALUES (
    3,
    'nukmaster',
    'nukmaster@vitekorp.com',
    2,
    encode(pgp_sym_encrypt('linvic2024', 'linvic2024'), 'hex'),
    true
  );

INSERT INTO userauthorities (authorityid, userid)
VALUES (
    1,
    3
  );