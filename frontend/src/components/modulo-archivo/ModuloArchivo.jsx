import { React,useState, useEffect, useRef } from "react";
import axios from "axios";
import { useAppContext } from "../../AppContext";
import { Container } from "@mui/system";
import { useNavigate } from "react-router-dom";
import { Button, Input, Typography } from "@mui/material";
import CheckGif from "../../assets/check.gif";
import { Box, Grid, TextField, CircularProgress } from "@mui/material";
import CloudUploadIcon from "@mui/icons-material/CloudUpload";
import FileUploadIcon from "@mui/icons-material/FileUpload";


const ModuloArchivo = () =>{
  
  const { usuarioObjeto, baseURL } = useAppContext();
  const instance = axios.create();
  instance.defaults.baseURL = baseURL;
  instance.defaults.timeout = 18000000;
  const navigate = useNavigate();
  const [selectedFile, setSelectedFile] = useState(null);
  const [loading, setLoading] = useState(false);
  const [check, setCheck] = useState(false);

  const buttonStyle = {
    color: "#FFFFFF",
  backgroundColor: "#453FC6",
  borderRadius: 2,
  ":hover": {
    bgcolor: "#3530a1",
    color: "white",
  }};


  const onFileChange = (event) => {
    setSelectedFile(event.target.files[0]);
  };

  useEffect(() => {}, [check]);

  const onFileUpload = async () => {
    if (selectedFile != null) {
      const formData = new FormData();
      formData.append("file", selectedFile);
      setLoading(true);
      const response = await instance.post("/analisisOptimizado/"+usuarioObjeto.current.id, formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });
      console.log(response.data);
      setCheck(true);
      setTimeout(() => {
        setLoading(false);
        setCheck(false);
        navigate("/dashboard");
      }, 3000);
    }
  };

  const renderFileDetails = () => {
    if (selectedFile != null) {
      return (
        <Box sx={{ mt: 2 }}>
          <Typography variant="h5" gutterBottom>
            Detalles del Archivo:
          </Typography>
          <Typography variant="body1" gutterBottom>
            Nombre: {selectedFile.name}
          </Typography>
          <Typography variant="body1" gutterBottom>
            Tipo: {selectedFile.type}
          </Typography>
          <Typography variant="body1" gutterBottom>
            Tamaño: {selectedFile.size} bytes
          </Typography>
          <Typography variant="body1" gutterBottom>
            Última modificación: {selectedFile.lastModifiedDate.toDateString()}
          </Typography>
        </Box>
      );
    } else {
      return (
        <Box sx={{ mt: 2 }}>
          <Typography variant="subtitle1" gutterBottom>
            Seleccione un archivo antes de presionar el botón Subir
          </Typography>
        </Box>
      );
    }
  };

  const renderLoading = () => {
    if (loading && !check) {
      return (
        <Box sx={{ display: "flex", alignItems: "center", flexDirection: "column", mt: 2 }}>
      <Typography variant="h4" gutterBottom sx={{ mt: 2 }}>
        Subiendo archivo...
      </Typography>
      <CircularProgress color="primary" size={300} maxSize={300} sx={{ mt: 2 }} />
    </Box>
      );
    } else if (check) {
      return (
        <Box sx={{ display: "flex", flexDirection: "column", justifyContent: "center", alignItems: "center", mt: 2 }}>
          <Typography variant="h4" gutterBottom sx={{ mt: 2 }}>
          Carga exitosa! Redirigiendo a los resultados
      </Typography>
        <img src={CheckGif} alt="Carga exitosa" style={{ size: 300 }}/>
      </Box>
      );
    } else {
      return null;
    }
  };

  return (
    <Container maxWidth="md" sx={{ mt: 4 }}>
      <Typography variant="h4" gutterBottom>
        Carga de Archivo
      </Typography>
      <Box sx={{ mt: 2 }}>
        <Grid container spacing={2} alignItems="center">
          <Grid item>
            <Button sx={{...buttonStyle}}
              variant="contained"
              component="label"
              startIcon={<FileUploadIcon />}
              disabled={loading}
            >
              Seleccionar Archivo
              <input
                type="file"
                accept=".txt"
                hidden
                onChange={onFileChange}
              />
            </Button>
          </Grid>
          <Grid item>
          <Button sx={{...buttonStyle}} disabled={loading} onClick={onFileUpload}
              variant="contained"
              color="primary"
              startIcon={<CloudUploadIcon />}
            >
              Subir
            </Button>
          </Grid>
        </Grid>
      </Box>
      {renderFileDetails()}
      {renderLoading()}
    </Container>
  );
};

export default ModuloArchivo;