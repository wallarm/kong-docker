return {
    postgres = {
      up = [[
        DO $$
        BEGIN
          ALTER TABLE IF EXISTS ONLY "routes"
            ADD COLUMN "wallarm_mode"                TEXT DEFAULT 'off',
            ADD COLUMN "wallarm_application"         BIGINT,
            ADD COLUMN "wallarm_parse_response"      BOOLEAN,
            ADD COLUMN "wallarm_parse_websocket"     BOOLEAN,
            ADD COLUMN "wallarm_unpack_response"     BOOLEAN,
            ADD COLUMN "wallarm_partner_client_uuid" UUID
          ;
        EXCEPTION WHEN DUPLICATE_COLUMN THEN
          -- Do nothing, accept existing state
        END;
        $$;
      ]],
    },

    cassandra = {
      up = [[
        ALTER TABLE routes ADD wallarm_mode                text;
        ALTER TABLE routes ADD wallarm_application         bigint;
        ALTER TABLE routes ADD wallarm_parse_response      boolean;
        ALTER TABLE routes ADD wallarm_parse_websocket     boolean;
        ALTER TABLE routes ADD wallarm_unpack_response     boolean;
        ALTER TABLE routes ADD wallarm_partner_client_uuid uuid;
      ]],
    },
  }
