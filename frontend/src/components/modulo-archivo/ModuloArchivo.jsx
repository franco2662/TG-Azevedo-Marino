import { React,useState, useEffect, useRef } from "react";
import axios from "axios";
import { useAppContext } from "../../AppContext";
import { Container } from "@mui/system";
import { useNavigate } from "react-router-dom";
import { Button } from "@mui/material";

const ModuloArchivo = () =>{
  
  const {usuarioObjeto} = useAppContext();
  const navigate = useNavigate();
  const uploadInputRef = useRef(null);
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
    console.log(reader.content); 
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
      
        <div>
        <h1>
          GeeksforGeeks
        </h1>
            <h3>
                File Upload using React!
            </h3>
            <div>
                <input type="file" onChange={onFileChange} />
                <button onClick={onFileUpload}>
                    Upload!
                </button>
            </div>
      {selectedFile != null ?
        
      
        <div>
          <h2>File Details:</h2>
          <p>File Name: {selectedFile.name}</p>

          <p>File Type: {selectedFile.type}</p>

          <p>
            Last Modified:{" "}
            {selectedFile.lastModifiedDate.toDateString()}
          </p>

        </div>
      
    : 
      
        <div>
          <br />
          <h4>Choose before Pressing the Upload button</h4>
        </div>
      
      }
    </div>
      );
}

export default ModuloArchivo;