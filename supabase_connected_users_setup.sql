-- Script SQL para crear la tabla de usuarios conectados en Supabase
-- Ejecuta este script en el SQL Editor de Supabase

-- Crear tabla para usuarios conectados
CREATE TABLE IF NOT EXISTS connected_users (
    id TEXT PRIMARY KEY,
    username TEXT NOT NULL,
    last_seen TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    status TEXT DEFAULT 'online',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear índices para mejorar el rendimiento
CREATE INDEX IF NOT EXISTS idx_connected_users_last_seen ON connected_users(last_seen DESC);
CREATE INDEX IF NOT EXISTS idx_connected_users_status ON connected_users(status);

-- Habilitar Row Level Security (RLS) si es necesario
-- ALTER TABLE connected_users ENABLE ROW LEVEL SECURITY;

-- Política de ejemplo: Permitir lectura y escritura pública
-- (Ajusta según tus necesidades de seguridad)
-- CREATE POLICY "Permitir acceso público a usuarios conectados" ON connected_users
--     FOR ALL
--     USING (true)
--     WITH CHECK (true);

-- Nota: Esta tabla rastrea usuarios conectados en tiempo real.
-- Los usuarios se consideran desconectados si su last_seen es mayor a 60 segundos.
-- La aplicación limpia automáticamente usuarios inactivos.

