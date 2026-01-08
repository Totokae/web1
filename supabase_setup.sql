-- Script SQL para crear la tabla en Supabase
-- Ejecuta este script en el SQL Editor de Supabase

CREATE TABLE IF NOT EXISTS grupos_data (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    group_a_data TEXT,
    group_b_data TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear índices para mejorar el rendimiento
CREATE INDEX IF NOT EXISTS idx_grupos_data_updated_at ON grupos_data(updated_at DESC);

-- Habilitar Row Level Security (RLS) si es necesario
-- ALTER TABLE grupos_data ENABLE ROW LEVEL SECURITY;

-- Política de ejemplo: Permitir lectura y escritura pública
-- (Ajusta según tus necesidades de seguridad)
-- CREATE POLICY "Permitir acceso público" ON grupos_data
--     FOR ALL
--     USING (true)
--     WITH CHECK (true);

