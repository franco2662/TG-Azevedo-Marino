import { React,useState, useEffect, useRef } from "react";
import axios from "axios";
import { useAppContext } from "../../AppContext";
import { Container } from "@mui/system";
import { useNavigate } from "react-router-dom";
import { Button, Input, Typography } from "@mui/material";

const ModuloArchivo = () =>{
  
  const {usuarioObjeto} = useAppContext();
  const navigate = useNavigate();
  const[selectedFile,setSelectedFile] =  useState(null);

  const onFileChange = (event) => {
    setSelectedFile(event.target.files[0]);   
  };

  const onFileUpload = () => {
    if(selectedFile!= null){

    var reader = new FileReader();

    reader.onload = function(e) {
            var content = reader.result;
            //Here the content has been read successfuly
            console.log(content);
        }

        reader.readAsText(selectedFile);
    //console.log(reader); 
    // Create an object of formData
    const formData = new FormData();
    
    // Update the formData object
    formData.append(
      "myFile",
      selectedFile,
      selectedFile.name
    );
    console.log(selectedFile);
    }
  };

    return (
      
      <Container>
        <Typography variant="h4" gutterBottom>
          Carga de Archivo
        </Typography>
        <Container>
          <Input type="file" onChange={onFileChange} />
        </Container>
      {selectedFile != null ?
        
      
        <Container>
          <Typography variant="h5" gutterBottom>
          Detalles del Archivo:
        </Typography>
          <p>File Name: {selectedFile.name}</p>

          <p>File Type: {selectedFile.type}</p>

          <p>
            Last Modified:{" "}
            {selectedFile.lastModifiedDate.toDateString()}
          </p>

        </Container>
      
    : 
      
        <div>
          <br />
            <Typography variant="subtitle1" gutterBottom>
              Seleccione un archivo antes de presionar el boton de Subir
            </Typography>
        </div>
      
      }
      
      <Button onClick={onFileUpload}>
            SUBIR
          </Button>
    </Container>
      );
}

export default ModuloArchivo;