@regresion
Feature: Automatizar el backend de Pet Store

  Background:
    * url apiPetStore
    * def jsonCrearMascota = read('classpath:examples/jsonData/crearMascota.json')
    * def jsonEditMascota = read('classpath:examples/jsonData/actualizarMascota.json')

  @TEST-1 @happypath @crearMascota
  Scenario: Verificar la creación de una nueva mascota en Pet Store - OK

    Given path 'pet'
    And request jsonCrearMascota
    When method post
    Then status 200
    And match response.id == And match response.id == '#number'
    And match response.name == 'Max'
    And match response.status == 'available'
    And print response
    * def idPet = response.id
    And print idPet

  @TEST-2 @happypath
  Scenario Outline: Verificar el estado de la mascota por los 3 estados (available, sold, pending) - OK
    Given path 'pet/findByStatus'
    And param status = '<estado>'
    When method get
    Then status 200
    And print response

    Examples:
      | estado    |
      | available |
      | sold      |
      | pending   |

  @TEST-3 @happypath
  Scenario: Verificar la actualización de una mascota  en pet store previamente registrada - OK

    Given path 'pet'
    * set jsonEditMascota.id = 3
    * set jsonEditMascota.name = 'Sassy'
    * set jsonEditMascota.status = 'sold'
    And request jsonEditMascota
    When method put
    Then status 200
    And print response

  @TEST-4
  Scenario Outline: Verificar la búsqueda de mascota por id - OK
    * def idMascota = call read('')
    Given path 'pet/' + '<idPet>'
    When method get
    Then status 200
    And print response

    Examples:
      | idPet |
      | 1     |
      | 2     |
      | 3     |

  @TEST-5
  Scenario Outline: Verificar la eliminación de la mascota por id (solo ids del test) - OK
    Given path 'pet/'+ '<idPet>'
    When method delete
    Then status 200
    And print response

    Examples:
      | idPet |
      | 1     |
      | 2     |
      | 3     |


  @TEST-6
  Scenario: Subir una imagen para una mascota existente - OK
    * def petId = 4
    Given path 'pet', petId, 'uploadImage'
    And multipart file file = { read: 'classpath:examples/imagenes/fotoPerfil.png', filename: 'fotoPerfil.png', contentType: 'image/png' }
    And multipart field additionalMetadata = 'Foto de perfil'
    When method post
    Then status 200

    #llamar a otro caso de prueba para usarlo después
  @TEST-7
  Scenario: Verificar la búsqueda de mascota por id - OK
    * def idMascota = call read('classpath:examples/users/users.feature@crearMascota')
    Given path 'pet/' + idMascota.idPet
    When method get
    Then status 200
    And print response


  # Comandos útiles:
  # mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @TEST-3"
  # mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @TEST-1"
  # mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @TEST-1" -Dkarate.env=cert