# Configuración de Supabase

Este documento explica cómo configurar Supabase para la aplicación de Análisis Exploratorio de Datos.

## Pasos de Configuración

### 1. Crear la tabla en Supabase

1. Accede a tu proyecto en Supabase: https://qkryjldoiandvrqqxszc.supabase.co
2. Ve a **SQL Editor** en el panel lateral
3. Ejecuta el script SQL del archivo `supabase_setup.sql`
   - Esto creará la tabla `grupos_data` con las columnas necesarias

### 2. Verificar las credenciales

El archivo `oa22sextob.html` ya está configurado con:
- **Project URL**: `https://qkryjldoiandvrqqxszc.supabase.co`
- **Publishable API Key**: `sb_publishable_qP8lp3-rT-f_6svcadtaHQ_b_KoqnmY`

### 3. Configurar políticas de seguridad (Opcional)

Si habilitas Row Level Security (RLS) en la tabla, necesitarás crear políticas. Puedes descomentar y ajustar las políticas en el archivo `supabase_setup.sql` según tus necesidades.

Para una aplicación pública básica, puedes deshabilitar RLS o crear una política que permita acceso público completo.

## Funcionalidades

### Guardar Datos
- Haz clic en el botón **"Guardar en Supabase"** para guardar los datos de los grupos A y B
- El estado se actualiza automáticamente y muestra un mensaje de confirmación

### Cargar Datos
- Al cargar la página, los datos se cargan automáticamente desde Supabase
- Se carga el registro más reciente guardado

### Notas Importantes
- La aplicación guarda los datos como JSON en las columnas `group_a_data` y `group_b_data`
- Se mantiene un ID de sesión (`currentSessionId`) para actualizar el mismo registro en lugar de crear uno nuevo cada vez
- Si quieres guardar automáticamente cada vez que agregues o elimines un punto, descomenta las líneas marcadas con `// saveDataToSupabase();` en el código

## Estructura de la Tabla

```sql
grupos_data
├── id (UUID) - Identificador único
├── group_a_data (TEXT) - Datos del Grupo A en formato JSON
├── group_b_data (TEXT) - Datos del Grupo B en formato JSON
├── created_at (TIMESTAMP) - Fecha de creación
└── updated_at (TIMESTAMP) - Fecha de última actualización
```

## Solución de Problemas

### Error: "relation 'grupos_data' does not exist"
- Verifica que hayas ejecutado el script SQL en Supabase
- Asegúrate de que la tabla se haya creado correctamente

### Error de autenticación
- Verifica que la API Key sea correcta y tenga permisos de lectura/escritura
- Asegúrate de que las políticas de seguridad permitan las operaciones necesarias

### Los datos no se cargan
- Verifica la consola del navegador para ver errores específicos
- Asegúrate de que haya datos guardados en Supabase
- Verifica que las políticas de RLS permitan la lectura

