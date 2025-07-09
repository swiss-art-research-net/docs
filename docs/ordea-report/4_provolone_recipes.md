This section contains a series of practical recipes and examples to exemplify how digital reading pipelines can be semantically modelled by following the principles outlined in [Section 3](./3_sem_modelling.md). 

Digital reading pipelines are broken down into a small number of core entities: 

-  a pipeline is made of distinct [**steps**](#pipeline-step), where the output of one step often serves as output to the following one;
- a pipeline is typically built in the context of a specific [**project**](#project), but the models and software it relies on may be reused within several pipelines across different projects;
- a pipeline uses, consumes, and produces [**digital objects**](#digital-object) (e.g., data, machine learning models, scripts, Jupyter notebooks).

For each of these entities, we define a *model*, consisting of its semantic fields (i.e., properties), and we provide examples in the form of JSON and Turtle of how these models and their fields should be mapped into semantic statements (RDF).

Finally, in the section [**URI templates**](#uri-templates) we provide some guidance for constructing URIs for specific entity types.

### *Project* model

**Description**: A project is the context within which a digital reading pipeline is created and implemented. (See [model documentation on Zellij](https://zellij.takin.delving.io/docs/display/appcQruLQ0OWFHWlX/Models?search=ANTM.15_Project)).

**Fields:**

 - *Name*: The name of the project (LAF.6)
 - *Actor*: A person or institution participating to he project (SRDF.129)
 - *Actor role*: The role played by a given person or institution in the project (SRDF.130)
 - *Description*: A description of the project (LAF.15)
 - *URL*: The URL of an online resource providing further information about the project (SRDF.369)

 **Example**

 > The BSO image classification pipeline was created by Florian Kräutli (knowledge graph engineer) in the context of the Bilder der Schweiz Online project, 

??? example "JSON"

    ```json
    {  
        // The project that constitutes the context 
        "project":{
            "id": "project/1234",
            "name": "Bilder der Schweiz Online (BSO)",
            "description": "The »Bilder der Schweiz online« (Images of Switzerland) initiative is a three-year project at the University of Zurich (2020-2022), jointly undertaken by Swiss Art Research Infrastructure (SARI) and the lecturer for Swiss Art and Museology at the Institute of Art History at the University of Zurich. ",
            "url": "https://www.sari.uzh.ch/en/Projects/bilder-der-schweiz-online.html",
            "contributors": [
                {
                    "name": "Florian Kräutli",
                    "role": "Knowledge Graph Engineer"
                }
            ]
        }
    }
    ```

??? example "JSON-LD"
    ```json
    TODO
    ```

??? example "Turtle"

    ```turtle
    http://www.cidoc-crm.org/cidoc-crm/> .
    @prefix crmdig: <http://www.ics.forth.gr/isl/CRMdig/> .
    @prefix crmpe: <http://parthenos.d4science.org/CRMext/CRMpe.rdfs/> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

    # Project: A project is the context within which a digital reading pipeline is created and implemented (ANTM.15)
    <https://examples.swissartresearch.net/project/1234> a crmpe:PE35_Project ;
        crm:P01i_is_domain_of <https://example.swissartresearch.net/property/SRDF.129_1> ;
        crm:P02i_is_range_of <https://example.swissartresearch.net/reified_property/SRDF.369_1> ;
        crm:P1_is_identified_by <https://examples.swissartresearch.net/project/1234/appellation/1> ;
        crm:P67i_is_referred_to_by <https://examples.swissartresearch.net/project/1234/linguisticobject/1> .

    #Actor: A person or institution participating to he project (SRDF.129)
    <https://examples.swissartresearch.net/person/1> a crm:E39_Actor ;
        crm:P1_is_identified_by <https://examples.swissartresearch.net/person/1/appellation/1> .

    <https://examples.swissartresearch.net/person/1/appellation/1> a crm:E33_E41_Linguistic_Appellation ;
        crm:P190_has_symbolic_content "Florian Kräutli" .

    # Description: A description of the project (LAF.15)
    <https://examples.swissartresearch.net/project/1234/linguisticobject/1> a crm:E33_Linguistic_Object ;
        crm:P190_has_symbolic_content "The »Bilder der Schweiz online« (Images of Switzerland) initiative is a three-year project at the University of Zurich (2020-2022), jointly undertaken by Swiss Art Research Infrastructure (SARI) and the lecturer for Swiss Art and Museology at the Institute of Art History at the University of Zurich. " .

    # Name: The name of the project (LAF.6)
    <https://examples.swissartresearch.net/project/1234/appellation/1> a crm:E33_E41_Linguistic_Appellation ;
        crm:P190_has_symbolic_content "Bilder der Schweiz Online (BSO)" .

    # Actor: A person or institution participating to the project (SRDF.129) -->
    <https://example.swissartresearch.net/property/SRDF.129_1> a crm:PC14_carried_out_by ;
        crm:P02_has_range <https://examples.swissartresearch.net/person/1> ;
        crm:P14.1_in_the_role_of <https://examples.swissartresearch.net/person/1/role/1> .

    # Actor role: The role played by a given person or institution in the project (SRDF.130) -->
    <https://examples.swissartresearch.net/person/1/role/1> a crm:E55_Type ;
        rdfs:label "Knowledge Graph Engineer" . 

    <https://example.swissartresearch.net/reified_property/SRDF.369_1> a crm:PC67_refers_to ;
        crm:P01_has_domain <https://example.swissartresearch.net/conceptual_object/SRDF.369_2> ;
        crm:P67.1_has_type <https://www.wikidata.org/wiki/Q42253> .

    # The URL of an online resource providing further information about the project
    <https://example.swissartresearch.net/conceptual_object/SRDF.369_2> a crmdig:D1_Digital_Object ;
        rdfs:label "https://www.sari.uzh.ch/en/Projects/bilder-der-schweiz-online.html" . 

    # URL (Q42253): web address to a particular file or page
    <https://www.wikidata.org/wiki/Q42253> a crm:E55_Type .
    ```

🚧 This section is still work-in-progress 🔜