const { Client } = require('pg');

async function seed() {
    const client = new Client({
        connectionString: 'postgresql://wajabat:wajabat_password@localhost:5432/wajabat'
    });

    try {
        await client.connect();

        // Check if cook already exists
        const res = await client.query("SELECT id FROM users WHERE email = 'nawal@wajabat.dz'");
        let cookId;

        if (res.rows.length === 0) {
            // Insert cook User
            const userRes = await client.query(`
        INSERT INTO "users" (email, name, role, status, avatar, "kycStatus", "createdAt", "updatedAt") 
        VALUES (
          'nawal@wajabat.dz', 
          'Nawal la Cuisinière', 
          'COOK', 
          'APPROVED',
          '👩‍🍳',
          'APPROVED',
          NOW(),
          NOW()
        ) RETURNING id;
      `);
            cookId = userRes.rows[0].id;
            console.log('Created cook with ID:', cookId);
        } else {
            cookId = res.rows[0].id;
            console.log('Cook already exists with ID:', cookId);
        }

        // Insert Dishes
        await client.query(`
      INSERT INTO "dishes" (name, description, price, stock, "cookId", "createdAt", "updatedAt") 
      VALUES 
        ('Couscous Royal Maison', 'Un couscous authentique avec légumes frais et viande d''agneau. Cuisiné ce matin.', 800, 10, $1, NOW(), NOW()),
        ('Tajine Zitoune', 'Tajine aux olives, poulet rôti au four, et champignons.', 900, 15, $1, NOW(), NOW()),
        ('Bourek à la Viande', 'Bourek maison farci à la viande hachée, persil, et fromages.', 150, 30, $1, NOW(), NOW());
    `, [cookId]);

        console.log('Created test dishes for cook', cookId);

    } catch (error) {
        console.error('Error seeding data:', error);
    } finally {
        await client.end();
    }
}

seed();
