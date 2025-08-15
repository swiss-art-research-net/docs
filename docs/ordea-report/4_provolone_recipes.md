This section contains a series of practical recipes and examples to exemplify how digital reading pipelines can be semantically modelled by following the principles outlined in [Section 3](./3_sem_modelling.md). 

Digital reading pipelines are broken down into a small number of core entities: 

-  a pipeline is made of distinct [**steps**](#pipeline-step), where the output of one step often serves as output to the following one;
- a pipeline is typically built in the context of a specific [**project**](#project), but the models and software it relies on may be reused within several pipelines across different projects;
- a pipeline uses, consumes, and produces [**digital objects**](#digital-object) (e.g., data, machine learning models, scripts, Jupyter notebooks).

For each of these entities, we define a *model*, consisting of its semantic fields (i.e., properties), and we provide examples in the form of JSON(-LD) of how these models and their fields should be mapped into semantic statements (RDF).

Finally, in the section [**URI templates**](#uri-templates) we provide some guidance for constructing URIs for specific entity types.

## Generic models

### Template

**Description**: TBA (See [model documentation on Zellij](link)).

**Fields:**

 - *Field_1*: Field_1 explanation
 - *Field_2*: Field_2 explanation

 **Example**

 > Example narrative

??? example "JSON-LD"
    ```json
    {
        "@context": [
            "https://linked.art/ns/v1/linked-art.json",
            {
            "crmdig": "http://www.ics.forth.gr/isl/CRMdig/",
            "DigitalObject":"crmdig:D1_Digital_Object"
            },
            {
            "crmpe": "http://parthenos.d4science.org/CRMext/CRMpe.rdfs/",
            "Project": "crmpe:PE35_Project"
            },
            {
            "aaao": "https://ontology.swissartresearch.net/aaao/"
            },
            {
            "crm":"http://www.cidoc-crm.org/cidoc-crm/",
            "has_dependency":"crm:P20_had_specific_purpose"
            },
            {
            "ex":"https://examples.swissartresearch.net/"
            }
        ],
        ...
    }
    ```

### `Project`

**Description**: A project is the context within which a digital reading pipeline is created and implemented. (See [model documentation on Zellij](https://zellij.takin.delving.io/docs/display/appcQruLQ0OWFHWlX/Models?search=PROM.15_Project)).

**Fields:**

 - *Name*: The name of the project (LAF.6)
 - *Actor*: A person or institution participating to the project (SRDF.129)
 - *Actor role*: The role played by a given person or institution in the project (SRDF.130)
 - *Description*: A description of the project (LAF.15)
 - *URL*: The URL of an online resource providing further information about the project (SRDF.369)

 **Example**

 > The BSO image classification pipeline was created by Florian Kräutli (knowledge graph engineer) in the context of the Bilder der Schweiz Online (BSO) project (https://www.sari.uzh.ch/en/Projects/bilder-der-schweiz-online.html). The »Bilder der Schweiz online« (Images of Switzerland) initiative is a three-year project at the University of Zurich (2020-2022), jointly undertaken by Swiss Art Research Infrastructure (SARI) and the lecturer for Swiss Art and Museology at the Institute of Art History at the University of Zurich.

??? example "JSON-LD"
    ```json
    {
        "@context": [
            "https://linked.art/ns/v1/linked-art.json",
            {
            "crmdig": "http://www.ics.forth.gr/isl/CRMdig/",
            "DigitalObject":"crmdig:D1_Digital_Object"
            },
            {
            "crmpe": "http://parthenos.d4science.org/CRMext/CRMpe.rdfs/",
            "Project": "crmpe:PE35_Project"
            },
            {
            "aaao": "https://ontology.swissartresearch.net/aaao/"
            },
            {
            "crm":"http://www.cidoc-crm.org/cidoc-crm/",
            "has_dependency":"crm:P20_had_specific_purpose"
            },
            {
            "ex":"https://examples.swissartresearch.net/"
            }
        ],
        "id": "ex:project/1234",
        "type": "Project",
        "identified_by":[
            {
                "type": "Name",
                "id": "ex:project/1234/appellation/1",
                "content": "Bilder der Schweiz Online (BSO)"
            },
            {
            "type": "Identifier",
            "id": "ex:project/1234/appellation/2",
            "content": "https://www.sari.uzh.ch/en/Projects/bilder-der-schweiz-online.html",
            "classified_as":{
                "type": "Type",
                "id": "https://vocab.getty.edu/aat/300404630",
                "rdfs:label":"URL"
                }
            }
        ],
        "referred_to_by":{
            "type": "LinguisticObject",
            "id": "ex:project/1234/linguisticobject/1",
            "content": "The »Bilder der Schweiz online« (Images of Switzerland) initiative is a three-year project at the University of Zurich (2020-2022), jointly undertaken by Swiss Art Research Infrastructure (SARI) and the lecturer for Swiss Art and Museology at the Institute of Art History at the University of Zurich. "
        },
        "crm:P01i_is_domain_of":{
            "type":"crm:PC14_carried_out_by",
            "id":"XXXXXX",
            "crm:P02_has_range":{
                "type":"Actor",
                "id":"ex:person/1",
                "identified_by":{
                    "type": "Name",
                    "id": "ex:person/1/appellation/1",
                    "content": "Florian Kräutli"
                }
            },
            "crm:P14.1_in_the_role_of":{
                "type":"Type",
                "rdfs:label":"Knowledge Graph Engineer",
                "id": "XXXXXX"
            }
        }
    }
    ```

### `Digital object`

**Description**: The digital object that is consumed/generated/used by a digital reading pipeline. (See [model documentation on Zellij](https://zellij.takin.delving.io/docs/display/appcQruLQ0OWFHWlX/Models?search=PROM.7_Digital+Object)).

**Fields:**

 - *Name*: The name of the digital object
 - *Identifier*: The identifier of the digital object
 - *Type*: The kind of digital object
 - *Description*: A description of the digital object
 - *Part of dataset*: The dataset of which a given digital object is part

  **Example**

 > TBD

 ??? example "JSON-LD"
    ```json
    {
        "@context": [
            "https://linked.art/ns/v1/linked-art.json",
            {
            "crmdig": "http://www.ics.forth.gr/isl/CRMdig/",
            "DigitalObject":"crmdig:D1_Digital_Object"
            },
            {
            "crm":"http://www.cidoc-crm.org/cidoc-crm/",
            "has_dependency":"crm:P20_had_specific_purpose"
            },
            {
            "ex":"https://examples.swissartresearch.net/"
            }
        ],
        "id": "ex:digitalobject/1234",
        "type": "DigitalObject",
        "identified_by":[
            {
                "type": "Name",
                "id": "ex:...",
                "content": "..."
            },
            {
            "type": "Identifier",
            "id": "ex:...",
            "content": "https://...",
            "classified_as":{
                "type": "Type",
                "id": "https://vocab.getty.edu/aat/300404630",
                "rdfs:label":"URL"
                }
            }
        ],
        "referred_to_by":{
            "type": "LinguisticObject",
            "id": "ex:...",
            "content": "..."
        }
    }
    ```


### `Software`

**Description**: A kind of digital object that is designed to be executed by a computing device and provide an algorithm for it to execute some function(s). (See [model documentation on Zellij](link)).

**Fields:**

 - *Name*: The name of the software
 - *Type*: The kind of software (remove?)
 - *Identifier*: An identifier for the software
 - *Description*: A description of the software
 - *URL*: The URL of an online resource providing information about the project or containing the software itself.

 **Example**

 > The Jupyter notebook available at https://github.com/swiss-art-research-net/bso-image-classification/blob/main/notebooks/model%20training.ipynb that was used to train the BSO image classification model.

??? example "JSON-LD"
    ```json
    {
        "@context": [
            "https://linked.art/ns/v1/linked-art.json",
            {
            "crmdig": "http://www.ics.forth.gr/isl/CRMdig/",
            "Software":"crmdig:D14_Software"
            },
            {
            "crm":"http://www.cidoc-crm.org/cidoc-crm/",
            "has_dependency":"crm:P20_had_specific_purpose"
            },
            {
            "ex":"https://examples.swissartresearch.net/"
            }
        ],
        "id": "ex:software/1234",
        "type": "Software",
        "identified_by":[
            {
                "type": "Name",
                "id": "ex:digitalobject/101112/appellation/1",
                "content": "model training.ipynb"
            },
            {
            "type": "Identifier",
            "id": "ex:digitalobject/101112/appellation/2",
            "content": "https://github.com/swiss-art-research-net/bso-image-classification/blob/main/notebooks/model%20training.ipynb",
            "classified_as":{
                "type": "Type",
                "id": "https://vocab.getty.edu/aat/300404630",
                "rdfs:label":"URL"
                }
            }
        ],
        "referred_to_by":{
            "type": "LinguisticObject",
            "id": "ex:software/1/linguisticobject/1",
            "content": "The Jupyter notebook that was used to train the BSO image classification model."
        }
    }
    ```

<!-- add also Service?-->

## Pipeline-related models

🚧 This section is still work-in-progress 🔜

## Semantics-related models

🚧 This section is still work-in-progress 🔜