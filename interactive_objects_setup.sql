-- Crear la tabla interactive_objects
CREATE TABLE IF NOT EXISTS interactive_objects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type TEXT NOT NULL DEFAULT 'whiteboard',
    content TEXT DEFAULT '',
    position_x INTEGER NOT NULL,
    position_y INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Habilitar Row Level Security (RLS)
ALTER TABLE interactive_objects ENABLE ROW LEVEL SECURITY;

-- Política RLS: SELECT - Público (todos pueden ver el contenido)
CREATE POLICY "Public read access for interactive_objects"
ON interactive_objects
FOR SELECT
USING (true);

-- Política RLS: UPDATE - Solo usuarios autenticados (Admins)
CREATE POLICY "Authenticated users can update interactive_objects"
ON interactive_objects
FOR UPDATE
USING (auth.role() = 'authenticated')
WITH CHECK (auth.role() = 'authenticated');

-- Política RLS: INSERT - Solo usuarios autenticados (Admins pueden crear objetos)
CREATE POLICY "Authenticated users can insert interactive_objects"
ON interactive_objects
FOR INSERT
WITH CHECK (auth.role() = 'authenticated');

-- Política RLS: DELETE - Solo usuarios autenticados (Admins pueden eliminar objetos)
CREATE POLICY "Authenticated users can delete interactive_objects"
ON interactive_objects
FOR DELETE
USING (auth.role() = 'authenticated');

-- Crear función para actualizar updated_at automáticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear trigger para actualizar updated_at
CREATE TRIGGER update_interactive_objects_updated_at
    BEFORE UPDATE ON interactive_objects
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Insertar una pizarra de ejemplo (opcional)
INSERT INTO interactive_objects (type, content, position_x, position_y)
VALUES ('whiteboard', 'Bienvenido a la pizarra virtual', 400, 300)
ON CONFLICT DO NOTHING;

