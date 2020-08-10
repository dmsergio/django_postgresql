# Django + PostgreSQL + Docker

Plantilla para levantar dos contenedores Docker interconectados, uno con la aplicación Django y otro con el servidor de 
PostgreSQL.

#### Cómo usar la plantilla para levantar el proyecto

1. Establecer una serie de variables de entorno en el fichero **env_template**, que se usarán cuando se vaya a 
levantar el proyecto:
    ```
   # Django
    DJANGO_PROJECT_NAME=my_project  # nombre a usar cuando se cree el directorio que contenga la app de Django
    # Postgres
    POSTGRES_DB=postgres  # nombre de la bbdd
    POSTGRES_USER=postgres  # usuario de la bbdd
    POSTGRES_PASSWORD=postgres  # contraseña para el usuario de la bbdd
    POSTGRES_HOST=db  # nombre o IP de la máquina que contendrá el servicio de Postgres
    POSTGRES_PORT=5432  # puerto de escucha del sercicio de Postgres
   ```
2. Establecer el mismo nombre de proyecto establecido anteriormente en el parámetro **DJANGO_PROJECT_NAME**, pero en 
este caso en la varialble **DJANGO_PROJECT** dentro del fichero Dockerfile.
    ```
   ARG DJANGO_PROJECT=my_project
   ```
3. Ejecutar el script **make_project.sh**. Este script tiene un único parámetro, y además es obligatorio:
    - -n/--name: Se trata del nombre del proyecto para que Django lo inicie (sería recomendable establecer el mismo 
    nombre usado en los parémtros anteriores). Ejemplos:
    ```
   ./make_project.sh -n my_project  # inicia un proyecto Django llamado my_project
   ./make_project.sh --name my_app  # inicia un proyecto Django llamado my_app
   ./make_project.sh --help  # muestra la ayuda del script
   ```
4. Una vez ejecutado el script se podrá observar dos cosas:
    - El contenedor de Postgres se habrá quedado en ejecución, pero sin embargo el contenedor de Django se habrá 
    caído. Esto es debido a que dicho contenedor no sabe a qué gestor de bbdd debe conectarse.
    - Se habrá creado en la carpeta raíz un directorio llamada tal y como se le ha indicado al script. Dicho directorio 
    contendrá todos los ficheros de nuestra app de Djago, incluídos los ficheros de ajustes necesarios para conectarse 
    al servidor de la bbdd necesario (en nuestro caso al contenedor de Postgres que ya está en marcha). Para ello hay 
    que abrir el fichero **settings.py** y modificar la variable DATABASES por lo siguiente:
    ```
   'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'postgres',  # mismo valor que el definido en el fichero env_template
        'USER': 'postgres',  # mismo valor que el definido en el fichero env_template
        'PASSWORD': 'postgres',  # mismo valor que el definido en el fichero env_template
        'HOST': 'db',  # nombre del servicio de Postgres definido en el fichero docker-compose.yml
        'PORT': 5432,  # puerto de escucha por defecto en el servicio de Postgres
    }
   ```
   Los valores referentes a las variables NAME, USER, y PASSWORD tienen que ser los mismos establecidos en el fichero 
   **env_template**. En cuanto a la varialbe HOST hacer referencia al nombre del servicio de Postgres definido en el 
   fichero **docker-compose.yml**.
