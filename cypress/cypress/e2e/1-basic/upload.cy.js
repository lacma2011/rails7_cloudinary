/// <reference types="cypress" />

// Welcome to Cypress!
//
// This spec file contains a variety of sample tests
// for a todo list app that are designed to demonstrate
// the power of writing tests in Cypress.
//
// To learn more about how Cypress works and
// what makes it such an awesome testing tool,
// please read our getting started guide:
// https://on.cypress.io/introduction-to-cypress

describe("example to-do app", () => {
  beforeEach(() => {
    // reset rails db, clean uploads folder and restart server
    cy.exec(
      'docker exec $(docker ps -q -f "name=backend") bundle exec rake db:schema:load'
    );

    cy.exec(
      'docker exec $(docker ps -q -f "name=backend") bundle exec rake db:seed'
    );

    cy.exec(
      'docker exec $(docker ps -q -f "name=backend") bundle exec rake clear_profiles_folder'
    );

    //cy.exec('docker exec $(docker ps -q -f "name=rails") bundle exec pumactl restart');
  });

  it("upload new image", () => {
    cy.visit("/");

    cy.intercept({
      method: "POST",
      url: "http://0.0.0.0:3001/signatures/processUpload/",
    }).as("upload");

    // upload image
    cy.get("input[type=file]").selectFile("cypress/fixtures/350x150.png", {
      action: "select",
    });

    // auto submits
    // cy.get('form').submit();

    const stub = cy.stub();
    cy.on("window:alert", stub);

    cy.wait("@upload").then(() => {
      expect(stub.getCall(0)).to.be.calledWith("image uploaded");
    });

    // visit page to check if image is there
    cy.visit("/gallery");

    cy.get("img")
      .first()
      .should("be.visible")
      .and(($img) => {
        // "naturalWidth" and "naturalHeight" are set when the image loads
        expect($img[0].naturalWidth).to.be.eql(350);
        expect($img[0].naturalHeight).to.be.eql(150);
      })
      .then(($img) => {
        return getBase64FromUrl($img[0].src);
      })
      .then((imgUploadedBase64) => {
        const image = "350x150.png";
        cy.fixture(image).then((originalLogoImage) => {
          //cy.writeFile('temp/myimage1.base64', imgUploadedBase64);
          //cy.writeFile('temp/myimage2.base64', 'data:image/png;base64,' + originalLogoImage);

          expect("data:image/png;base64," + originalLogoImage).to.eql(
            imgUploadedBase64
          );
        });
      });
  });
});

const getBase64FromUrl = async (url) => {
  const data = await fetch(url);
  const blob = await data.blob();
  return new Promise((resolve) => {
    const reader = new FileReader();
    reader.readAsDataURL(blob);
    reader.onloadend = () => {
      const base64data = reader.result;
      resolve(base64data);
    };
  });
};
