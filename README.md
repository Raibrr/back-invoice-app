
# Guía para Arrancar el Proyecto

Esta guía te ayudará a configurar y ejecutar el proyecto en tu entorno local paso a paso.

---

## 1. **Requisitos Previos**

Asegúrate de tener instaladas las siguientes herramientas:

- Ruby 3.x (o versión especificada en el proyecto)
- Rails 7.x
- PostgreSQL
- Redis (para caché y Sidekiq)
- Bundler (gem install bundler)
- Node.js y Yarn

---

## 2. **Clonar el Repositorio**

Clona el repositorio en tu máquina local:

```bash
git clone <URL_DEL_REPOSITORIO>
cd <NOMBRE_DEL_PROYECTO>
```

---

## 3. **Instalar Dependencias**

### Ruby

Instala las dependencias necesarias:

```bash
bundle install
```

---

## 4. **Configurar Variables de Entorno**

Crea un archivo `.env` en la raíz del proyecto y agrega las siguientes variables:

```dotenv
HOST=
USERNAME=
DB_PASSWORD=
REDIS_URL=redis://localhost:6379/0
```

---

## 5. **Configurar la Base de Datos**

### Crear la base de datos
Si es necesario crearla (solo en local):

```bash
rails db:create
```

### Cargar la estructura

```bash
rails db:schema:load
```

---

## 6. **Ejecutar Redis y Sidekiq**

Inicia Redis en una terminal:

```bash
redis-server
```

En otra terminal, inicia Sidekiq:

```bash
bundle exec sidekiq
```

---

## 7. **Ejecutar el Servidor**

Inicia el servidor Rails:

```bash
rails s
```

La aplicación estará disponible en `http://localhost:3000`.

---

## 8. **Pruebas y Verificación**

### Verificar Conexión a la Base de Datos

```bash
rails console
```
Ejecuta un query para asegurarte de que la base de datos está conectada.

### Probar el Caché

En consola Rails:

```ruby
Rails.cache.write("test_key", "test_value")
Rails.cache.read("test_key") # Debería devolver "test_value"
```

### Verificar Tareas en Background

Asegúrate de que las tareas en Sidekiq estén procesándose correctamente en `http://localhost:3000/sidekiq`.

---

## 9. **Programar Cron Jobs**

Utiliza `whenever` para manejar tareas recurrentes. Actualiza el cron:

```bash
whenever --update-crontab
```

Verifica las tareas programadas:

```bash
crontab -l
```

---

Con esta configuración, tu proyecto debería estar listo para ejecutarse correctamente en tu entorno local. Si encuentras algún problema, consulta los logs generados o verifica las configuraciones nuevamente.

