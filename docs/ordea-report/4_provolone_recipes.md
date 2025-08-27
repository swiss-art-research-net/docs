This section contains a series of practical recipes and examples to exemplify how digital reading pipelines can be semantically modelled by following the principles outlined in [Section 3](./3_sem_modelling.md). 

Digital reading pipelines are broken down into a small number of core entities: 

-  a pipeline is made of distinct [**steps**](#pipeline-step), where the output of one step often serves as output to the following one;
- a pipeline is typically built in the context of a specific [**project**](#project), but the models and software it relies on may be reused within several pipelines across different projects;
- a pipeline uses, consumes, and produces [**digital objects**](#digital-object) (e.g., data, machine learning models, scripts, Jupyter notebooks).

For each of these entities, we define a *model*, consisting of its semantic fields (i.e., properties), and we provide examples in the form of JSON(-LD) of how these models and their fields should be mapped into semantic statements (RDF).

Finally, in the section [**URI templates**](#uri-templates) we provide some guidance for constructing URIs for specific entity types.

## Generic models

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

 > The CSV file at https://raw.githubusercontent.com/swiss-art-research-net/bso-image-classification/refs/heads/main/data/imageAnnotations.csv which contains labeled data for image classification in the BSO project.

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
            "ex":"https://examples.swissartresearch.net/"
            }
        ],
        "id": "digitalobject/5678",
        "type": "DigitalObject",
        "identified_by":[
            {
                "type": "Name",
                "id": "ex:digitalobject/5678/appellation/1",
                "content": "data/imageAnnotations.csv"
            },
            {
            "type": "Identifier",
            "id": "ex:digitalobject/5678/appellation/2",
            "content": "https://raw.githubusercontent.com/swiss-art-research-net/bso-image-classification/refs/heads/main/data/imageAnnotations.csv",
            "classified_as":{
                "type": "Type",
                "id": "https://vocab.getty.edu/aat/300404630",
                "rdfs:label":"URL"
                }
            }
        ],
        "referred_to_by":{
            "type": "LinguisticObject",
            "id": "ex:digitalobject/5678/linguisticobject/1",
            "content": "CSV file containing labeled data for image classification in the BSO project."
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

<!-- add also Service? this could be the GTA SPARQL API for image similarity-->

## Pipeline-related models

### Generic pipeline step 

**Generic fields:**

 - *Type*: The type of the pipeline step, typically expressed by means of a controlled vocabulary (LAF.11)
 - *Name*: The name of the pipeline step (LAF.6)
 - *Description*: A brief description of the pipeline step (LAF.15)
 - *Timestamp – begin*: The timestamp of the date when a given pipeline step started (LAF.25)
 - *Timestamp – end*: The timestamp of the date when a given pipeline step ended (LAF.26)
 - *Part of project*: The project within which the pipeline step was carried out (LAF.42)
 - *Dependency*: The subsequent step in the pipeline sequence (PROF.3)

### Labelling step

**Description**: The step in a digital reading pipeline that involves creating manually labelled examples for evaluating or training a machine learning model. (See [model documentation on Zellij](link)).

**Specific fields (in addition to the generic ones):**

 - *Tool*: The digital tool to perform data labeling (SEMF.133) 
 - *Input*: The input digital objects (e.g. texts, images, etc.) on which labeling is performed (SEMF.35)
 - *Output*: A collection of manually labeled digital objects. The type of labels directly depends on the ML task at hand (SEMF.34)
 - *Log file*: Optionally, the labeling process may produce a log file where system and user actions are logged (ANTF.1)
 - *Annotator*: The human annotator(s) involved in the labeling process (LAF.21)
 - *Tool*: The digital tool to perform data labeling (SEMF.133)
 - *Platform used*: The platform where a given tool is hosted and offered as a service (PROF.20)

 **Example**

 > The image labelling step of the digital reading pipeline developed by SARI for the Bilder der Schweiz Online (BSO) project .

??? example "JSON-LD"
    ```json
    {
        "@context": [
            "https://linked.art/ns/v1/linked-art.json",
            {
            "crmdig": "http://www.ics.forth.gr/isl/CRMdig/",
            "DigitalObject":"crmdig:D1_Digital_Object",
            "DigitalMachineEvent": "crmdig:D7_Digital_Machine_Event"
            },
            {
            "crmpe": "http://parthenos.d4science.org/CRMext/CRMpe.rdfs/",
            "Project": "crmpe:PE35_Project"
            },
            {
            "aaao": "https://ontology.swissartresearch.net/aaao/",
            "DigitalReading": "aaao:ZE17_Digital_Reading"
            },
            {
                "crm":"http://www.cidoc-crm.org/cidoc-crm/",
                "part_of": "crm:P9i_forms_part_of",
                "dependency": "crm:P20_had_specific_purpose",
                "input": "crm:L10_had_input",
                "output": "crm:L11_had_output"
            },
            {
            "ex":"https://examples.swissartresearch.net/",
            "provoc":"https://vocab.swissartresearch.net/"
            }
        ],
        "id":"ex:/digitalreading/1234",
        "type":"DigitalReading",
        "_label": "BSO Image Labeling",
        "begin_of_the_begin":"2023-05-12T10:15:30Z",
        "end_of_the_end": "2023-05-12T10:15:30Z",
        "classified_as": "provoc:/Labelling",
        "part_of": {
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
            ]
        },
        "input":{
            "id": "digitalobject/1234",
            "type": "DigitalObject",
            "identified_by":[
            {
                "type": "Name",
                "id": "ex:digitalobject/1234/appellation/1",
                "content": "images/"
            },
            {
                "type": "Identifier",
                "id": "ex:digitalobject/1234/appellation/2",
                "content": "https://raw.githubusercontent.com/swiss-art-research-net/bso-image-classification/refs/heads/main/images/",
                "classified_as":{
                    "type": "Type",
                    "id": "https://vocab.getty.edu/aat/300404630",
                    "rdfs:label":"URL"
                    }
                }
            ],
            "referred_to_by":{
                "type": "LinguisticObject",
                "id": "ex:digitalobject/1234/linguisticobject/1",
                "content": "Folder containing downloaded images."
            }
        }
        ,
        "output": {
            "id": "digitalobject/5678",
            "type": "DigitalObject",
            "identified_by":[
            {
                "type": "Name",
                "id": "ex:digitalobject/5678/appellation/1",
                "content": "data/imageAnnotations.csv"
            },
            {
            "type": "Identifier",
            "id": "ex:digitalobject/5678/appellation/2",
            "content": "https://raw.githubusercontent.com/swiss-art-research-net/bso-image-classification/refs/heads/main/data/imageAnnotations.csv",
            "classified_as":{
                "type": "Type",
                "id": "https://vocab.getty.edu/aat/300404630",
                "rdfs:label":"URL"
                }
            }
            ],
            "referred_to_by":{
                "type": "LinguisticObject",
                "id": "ex:digitalobject/5678/linguisticobject/1",
                "content": "CSV file containing labeled data for image classification in the BSO project."
            }
        },
        "dependency": {
            "id": "ex:/digitalreading/1234",
            "_label": "BSO Model Training",
            "classified_as": "provoc:ModelTraining"
        }
    }
    ```

### Model training step

🚧 This section is still work-in-progress 🔜

**Description**: The step of a digital reading pipeline that consists in training a machine learning statistical model for performing a given task, typically by means of a manually labelled dataset (See [model documentation on Zellij](https://zellij.takin.delving.io/docs/display/appcQruLQ0OWFHWlX/Models?search=PROM.3_Digital+Reading+-+Model+Training)).

**Fields:**

 - *Input*: The labeled data (e.g. texts, images, etc.) that was used to train the model (SEMF.35)
 - *Output*: The trained model produced (SEMF.34)
 - *Log file*: Optionally, the model training process may produce a log file (PROF.1)
 - *Code*: Script/notebook used to train the model. (SEMF.133)
 - *Service*: External platform used to train the model (e.g. Roboflow Train) (PROF.20)

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

### Prediction step

**Description**: The step of a digital reading pipeline at which a statistical machine learning model makes predictions on unseen data (See [model documentation on Zellij](https://zellij.takin.delving.io/docs/display/appcQruLQ0OWFHWlX/Models?search=PROM.4_Digital+Reading+-+Prediction)).

**Fields:**

- *Input*: A set of input digital objects (SEMF.35)
- *Output*: Digital object(s) containing the model's predictions (SEMF.34)
- *Log file*: Optionally, the prediction process may produce a log file (ANTF.1)
- *Code*: Script/notebook used to obtain the predictions (SEMF.133)
- *Model*: The trained model used to generate predictions (SEMF.35)
- *API*: External API service used to obtain the predictions, as an alternative to a (local) model (PROF.20).

 **Example**

 > The prediction step of the BSO image classification pipeline; it takes as input the images at `images/`, it classifies them by using the trained model `model.pkl` for inference, and finally writes the predictions to file `output/predictions.csv`.

??? example "JSON-LD"
    ```json
    {
        "@context": [
            "https://linked.art/ns/v1/linked-art.json",
            {
            "crmdig": "http://www.ics.forth.gr/isl/CRMdig/",
            "DigitalObject":"crmdig:D1_Digital_Object",
            "DigitalMachineEvent": "crmdig:D7_Digital_Machine_Event"
            },
            {
            "crmpe": "http://parthenos.d4science.org/CRMext/CRMpe.rdfs/",
            "Project": "crmpe:PE35_Project"
            },
            {
            "aaao": "https://ontology.swissartresearch.net/aaao/",
            "DigitalReading": "aaao:ZE17_Digital_Reading"
            },
            {
                "crm":"http://www.cidoc-crm.org/cidoc-crm/",
                "part_of": "crm:P9i_forms_part_of",
                "dependency": "crm:P20_had_specific_purpose",
                "input": "crm:L10_had_input",
                "output": "crm:L11_had_output",
                "model": "crm:L10_had_input"
            },
            {
            "ex":"https://examples.swissartresearch.net/",
            "provoc":"https://vocab.swissartresearch.net/"
            }
        ],
        "id":"ex:digitalreading/101112",
        "type":"DigitalReading",
        "_label": "BSO Image Classification Prediction",
        "begin_of_the_begin":"2023-05-12T10:15:30Z",
        "end_of_the_end": "2023-05-12T10:19:30Z",
        "classified_as": "provoc:/Prediction",
        "part_of": {
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
            ]
        },
        "referred_to_by":{
            "type": "LinguisticObject",
            "id": "ex:/digitalreading/101112/linguisticobject/1",
            "content": "Prediction of image classes on unseen data from the BSO project."
        },
        "model": {
            "id": "ex:digitalobject/91011"
        },
        "input": {
            "id": "ex:digitalobject/1234"
        },
        "output": {
            "id": "ex:digitalobject/151617",
            "type": "DigitalObject",
            "identified_by":[
                {
                    "type": "Name",
                    "id": "ex:digitalobject/151617/appellation/1",
                    "content": "output/predictions.csv"
                },
                {
                "type": "Identifier",
                "id": "ex:digitalobject/151617/appellation/2",
                "content": "https://github.com/swiss-art-research-net/bso-image-classification/blob/main/output/predictions.csv",
                "classified_as":{
                    "id": "https://vocab.getty.edu/aat/300404630"
                }
                }
            ],
        "referred_to_by":{
                "type": "LinguisticObject",
                "id": "ex:digitalobject/151617linguisticobject/1",
                "content": "The file where the image classification results are written."
            }
        }
    }
    ```

### Data transformation step

**Description**: TBD. (See [model documentation on Zellij](link)).

**Specific fields (in addition to the generic ones):**

 - *Tool*: The digital tool to perform data labeling (SEMF.133) 
 - ...

 **Example**

 > The conversion of the CSV file contaning the model's predictions (`output/predictions.csv`) into RDF format (`output/classifications.trig`), performed by means of the Jupyter notebook `notebooks/create RDF output.ipynb`. 


### Data analysis step

## Semantics-related models

🚧 This section is still work-in-progress 🔜