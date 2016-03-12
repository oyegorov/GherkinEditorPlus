Feature: Uploading APNS certificate
    In order to start enrolling iOS devices
    Administrator wants to upload APNS certificate to the server

Scenario: Uploading APNS certificate
	Given I am a user with name 'Administrator' and password '1'
	When I upload an APNS certificate from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\iOS_Certificate.pfx' with password '123456'
	Then The certificate is uploaded successfully