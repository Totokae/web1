# Configuración de Usuarios Conectados en juegos.html

Este documento explica cómo configurar la funcionalidad de usuarios conectados en tiempo real usando Supabase.

## Pasos de Configuración

### 1. Crear la tabla en Supabase

1. Accede a tu proyecto en Supabase: https://qkryjldoiandvrqqxszc.supabase.co
2. Ve a **SQL Editor** en el panel lateral
3. Ejecuta el script SQL del archivo `supabase_connected_users_setup.sql`
   - Esto creará la tabla `connected_users` con las columnas necesarias

### 2. Habilitar Realtime en Supabase

Para que la funcionalidad de tiempo real funcione correctamente:

1. En el panel de Supabase, ve a **Database** > **Replication**
2. Busca la tabla `connected_users`
3. Habilita la replicación en tiempo real (toggle ON) para la tabla `connected_users`
4. Esto permitirá que los cambios se propaguen instantáneamente a todos los usuarios conectados

### 3. Verificar las credenciales

El archivo `juegos.html` ya está configurado con:
- **Project URL**: `https://qkryjldoiandvrqqxszc.supabase.co`
- **Publishable API Key**: `sb_publishable_qP8lp3-rT-f_6svcadtaHQ_b_KoqnmY`

### 4. Configurar políticas de seguridad (Opcional)

Si habilitas Row Level Security (RLS) en la tabla, necesitarás crear políticas. Puedes descomentar y ajustar las políticas en el archivo `supabase_connected_users_setup.sql` según tus necesidades.

Para una aplicación pública básica, puedes:
- Deshabilitar RLS en la tabla `connected_users`, o
- Crear una política que permita acceso público completo

## Funcionalidades Implementadas

### Modal de Entrada de Usuario
- Al cargar la página, se muestra un modal para ingresar el nombre de usuario
- El nombre se guarda en `localStorage` para no pedirlo nuevamente en futuras visitas
- Se puede cambiar el nombre limpiando el localStorage: `localStorage.removeItem('juegos_username')`

### Panel de Usuarios Conectados
- **Ubicación**: Panel izquierdo, debajo del título "Leyenda de Puntajes"
- **Contador**: Muestra el número de usuarios conectados en un badge verde
- **Lista**: Muestra todos los nombres de usuario conectados con un indicador de estado (punto verde pulsante)

### Sincronización en Tiempo Real
- Los usuarios se agregan automáticamente cuando ingresan
- Los usuarios se eliminan automáticamente cuando se desconectan (después de 60 segundos de inactividad)
- La lista se actualiza en tiempo real usando Supabase Realtime
- El `last_seen` se actualiza cada 30 segundos mientras el usuario está en la página

### Limpieza Automática
- Los usuarios inactivos (sin actualizar `last_seen` por más de 60 segundos) se eliminan automáticamente
- La limpieza se ejecuta cada minuto

## Estructura de la Tabla

```sql
connected_users
├── id (TEXT) - Identificador único del usuario (generado automáticamente)
├── username (TEXT) - Nombre de usuario ingresado
├── last_seen (TIMESTAMP) - Última vez que se actualizó la presencia
├── status (TEXT) - Estado del usuario (default: 'online')
└── created_at (TIMESTAMP) - Fecha de creación del registro
```

## Solución de Problemas

### Error: "relation 'connected_users' does not exist"
- Verifica que hayas ejecutado el script SQL en Supabase
- Asegúrate de que la tabla se haya creado correctamente

### Los usuarios no aparecen en tiempo real
- Verifica que hayas habilitado Realtime para la tabla `connected_users` en Supabase
- Ve a **Database** > **Replication** y habilita el toggle para `connected_users`

### Error de autenticación
- Verifica que la API Key sea correcta y tenga permisos de lectura/escritura
- Asegúrate de que las políticas de RLS permitan las operaciones necesarias (o deshabilita RLS)

### Los usuarios no se eliminan automáticamente
- La limpieza se ejecuta cada minuto
- Los usuarios se consideran desconectados si su `last_seen` es mayor a 60 segundos
- Verifica la consola del navegador para ver si hay errores

### El modal no aparece
- Limpia el localStorage: `localStorage.removeItem('juegos_username')`
- Recarga la página

## Notas Importantes

- El nombre de usuario se guarda en `localStorage` con la clave `juegos_username`
- Cada sesión del navegador tiene un ID único generado automáticamente
- Los usuarios se consideran conectados si han actualizado su `last_seen` en los últimos 60 segundos
- Al cerrar la pestaña o navegar fuera, el usuario se eliminará automáticamente después de 60 segundos de inactividad

