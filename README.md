# Guía de Comandos Útiles para Terraform

---

### Introducción

Este documento sirve como una referencia rápida y práctica de comandos esenciales para gestionar y operar proyectos de **Terraform**. Abarca desde la configuración básica y la validación, hasta la gestión avanzada de estados y variables. El objetivo es proporcionar una guía clara para mantener un flujo de trabajo eficiente y profesional.

---

### Comandos de Gestión y Validación

Estos comandos son fundamentales para preparar y verificar tu configuración antes de realizar cualquier cambio en la infraestructura.

* **Formatear archivos**:
    ```bash
    terraform fmt -recursive
    ```
    Formatea todos los archivos de configuración (`.tf`) en el directorio actual y sus subdirectorios para asegurar una sintaxis y un estilo consistentes.
* **Validar configuración**:
    ```bash
    terraform validate
    ```
    Verifica que la sintaxis de los archivos de configuración sea válida y que los módulos y las variables estén correctamente declarados.

---

### Planificación y Aplicación de Cambios

Estos comandos te permiten visualizar, exportar y aplicar cambios de manera controlada.

* **Exportar archivo de plan**:
    ```bash
    terraform plan -out myplan
    ```
    Genera un plan de ejecución y lo guarda en un archivo binario llamado `myplan`. Esto es útil para revisar los cambios de manera segura antes de aplicarlos.
* **Aplicar plan desde un archivo**:
    ```bash
    terraform apply myplan
    ```
    Aplica los cambios definidos en el archivo `myplan` sin necesidad de generar un nuevo plan.
* **Ver estado de un archivo de plan**:
    ```bash
    terraform show myplan
    ```
    Muestra una representación legible del plan guardado en `myplan`, incluyendo los cambios que se aplicarán.

---

### Gestión del Estado

El estado de **Terraform** es crucial para el seguimiento de los recursos. Estos comandos te ayudan a interactuar con él.

* **Ver estado actual**:
    ```bash
    terraform show
    ```
    Muestra el estado actual de los recursos gestionados por **Terraform**.
* **Listar recursos**:
    ```bash
    terraform state list
    ```
    Enumera todos los recursos que **Terraform** está gestionando en el estado actual.
* **Cambiar el nombre de un recurso en el estado**:
    ```bash
    terraform state mv aws_instance.namethis aws_instance.new
    ```
    Cambia el nombre de una instancia en el estado sin recrear el recurso.
* **Simular cambio de nombre sin aplicarlo**:
    ```bash
    terraform state mv -dry-run aws_instance.namethis aws_instance.new
    ```
    Muestra cómo se renombraría un recurso, pero **sin confirmar el cambio**. Terraform lo considerará como destrucción y creación en un plan real.
* **Importar recurso existente a Terraform**:
    ```bash
    terraform import aws_s3_bucket.remote_state 'terraform-course-aitorconesa'
    ```
    Importa un recurso creado manualmente en AWS (o fuera de Terraform) para que pase a ser gestionado por Terraform.
* **Eliminar recurso del estado (no de AWS)**:
    ```bash
    terraform state rm -dry-run aws_s3_bucket.my_bucket
    ```
    Quita un recurso del estado de Terraform, sin eliminarlo en AWS. El `-dry-run` permite simular la operación.

---

### Destrucción de Infraestructura

Estos comandos son utilizados para eliminar recursos de manera segura.

* **Generar plan de destrucción**:
    ```bash
    terraform plan -destroy
    ```
    Crea un plan de ejecución que detalla qué recursos serán destruidos.
* **Destruir recursos aplicados**:
    ```bash
    terraform apply -destroy
    ```
    Elimina todos los recursos gestionados por la configuración actual. Puedes usar la bandera `-auto-approve` para confirmar automáticamente la acción.
    ```bash
    terraform apply -destroy -auto-approve
    ```

---

### Reconfiguración y Migración

Estos comandos son útiles cuando necesitas modificar la configuración del *backend* o inicializar un proyecto que ya existe.

* **Reconfigurar un proyecto inicializado**:
    ```bash
    terraform init --reconfigure
    ```
    Reinicializa el directorio de trabajo de **Terraform** sin modificar la configuración del *backend* o el estado existente.
* **Migrar *backend***:
    ```bash
    terraform init -backend-config="dev.s3.tfbackend" -migrate-state
    ```
    Migra el archivo de estado de **Terraform** al *backend* especificado en el archivo de configuración.

---

### Gestión de Variables

Controlar las variables es esencial para entornos dinámicos.

* **Especificar archivo de variables**:
    ```bash
    terraform plan -var-file="dev.terraform.tfvars"
    ```
    Utiliza un archivo específico (`dev.terraform.tfvars`) para proporcionar valores a las variables de tu configuración.
* **Crear variable de entorno**:
    ```bash
    export TF_VAR_nombre_de_la_variable="valor"
    ```
    Define variables de **Terraform** a través del entorno, lo que es útil para la automatización.

#### Orden de Precedencia de las Variables
**Terraform** evalúa las variables en un orden específico, donde las últimas opciones tienen prioridad sobre las primeras:
1.  Valores predeterminados (`defaults`)
2.  Variables de entorno (`TF_VAR_*`)
3.  Archivos de variables (`.tfvars`)
4.  Archivos de variables automáticas (`.auto.tfvars`)
5.  Banderas de línea de comandos (`-var` y `-var-file`)
    * **Ejemplo `-var`**: `terraform plan -var=ec2_instance_type=t3.xlarge`
    * **Ejemplo `-var-file`**: `terraform plan -var-file="dev.terraform.tfvars"`
