const fs = require('fs');
const path = require('path');
const Database = require('better-sqlite3');

const root = path.join(__dirname, '..', '..');
const dbPath = path.join(root, 'data', 'ejari.sqlite');
const schemaPath = path.join(__dirname, 'schema.sql');

fs.mkdirSync(path.dirname(dbPath), { recursive: true });

const db = new Database(dbPath);
const schema = fs.readFileSync(schemaPath, 'utf8');
db.exec(schema);

const insertUser = db.prepare(`
  INSERT OR REPLACE INTO users (id, full_name, role, id_number, phone, email, is_verified)
  VALUES (@id, @full_name, @role, @id_number, @phone, @email, @is_verified)
`);

const insertProperty = db.prepare(`
  INSERT OR REPLACE INTO properties (
    id, owner_id, title, governorate, location, rooms, bathrooms, area_sqm, price_monthly, description
  ) VALUES (
    @id, @owner_id, @title, @governorate, @location, @rooms, @bathrooms, @area_sqm, @price_monthly, @description
  )
`);

const insertContract = db.prepare(`
  INSERT OR REPLACE INTO contracts (
    id, tenant_id, property_id, status, monthly_rent, address_label, start_date, end_date
  ) VALUES (
    @id, @tenant_id, @property_id, @status, @monthly_rent, @address_label, @start_date, @end_date
  )
`);

insertUser.run({
  id: 'u-owner-1',
  full_name: 'محمد الأحمد',
  role: 'owner',
  id_number: null,
  phone: '+962791111111',
  email: 'owner@ejari.jo',
  is_verified: 1,
});

insertUser.run({
  id: 'u-tenant-1',
  full_name: 'أحمد الأحمد',
  role: 'tenant',
  id_number: '9851234567',
  phone: '+962 79 123 4567',
  email: 'ahmad@gmail.com',
  is_verified: 1,
});

insertProperty.run({
  id: 'p-1',
  owner_id: 'u-owner-1',
  title: 'شقة مفروشة - الصويفية',
  governorate: 'عمان',
  location: 'الصويفية - عمان',
  rooms: 2,
  bathrooms: 1,
  area_sqm: 120,
  price_monthly: 350,
  description: 'شقة حديثة قريبة من الخدمات.',
});

insertContract.run({
  id: 'c-1',
  tenant_id: 'u-tenant-1',
  property_id: 'p-1',
  status: 'active',
  monthly_rent: 350,
  address_label: 'عمان - الصويفية، شارع الوكالات',
  start_date: '2024-06-01',
  end_date: '2025-06-01',
});

db.close();
console.log('Database ready at', dbPath);
