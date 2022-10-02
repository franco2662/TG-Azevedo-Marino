import * as React from 'react';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import CssBaseline from '@mui/material/CssBaseline';
import TextField from '@mui/material/TextField';
import FormControlLabel from '@mui/material/FormControlLabel';
import Checkbox from '@mui/material/Checkbox';
import Link from '@mui/material/Link';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import { Modal } from '@mui/material';
import { useState } from 'react';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import Select, { SelectChangeEvent } from '@mui/material/Select';
import axios from 'axios';

const baseURL = "http://127.0.0.1:8000/";


const style = {
  position: 'absolute',
  top: '50%',
  left: '50%',
  transform: 'translate(-50%, -50%)',
  width: 800,
  bgcolor: 'background.paper',
  border: '2px solid #000',
  boxShadow: 24,
  p: 4,
};


const Register = ({onCloseModal}) => {

  const instance = axios.create()
  instance.defaults.baseURL = baseURL;
  const [isLoading, setIsLoading] = React.useState(false);
  const [gender, setGender] = React.useState('');

  const handleGenderChange = (event: SelectChangeEvent) => {
    setGender(event.target.value);
  };

  const [rol, setRol] = React.useState('');

  const handleRolChange = (event: SelectChangeEvent) => {
    setRol(event.target.value);
  };

  const initialStatePersona = {nombre:" ",apellido: " ",fechaNac: " ",docIdent: " ", sexo: " "};
  const[persona, setPersona] = useState(initialStatePersona);

  const handleInputChange = (e) => {

    setPersona({ ...persona, [e.target.name]: e.target.value });

  }

  const handleSubmit = async(e) => {
    e.preventDefault();
    try{
      setIsLoading(true);
      const json_request = JSON.stringify(persona);
      const payloadPersona = { 
        nombre:persona.nombre,
        apellido:persona.apellido,
        sexo:persona.sexo,
        docidentidad:persona.docIdent,
        fechanac:persona.fechaNac
      }
      //Aca va el otro payload
      console.log(payloadPersona);
    const [responseInsertPerson,responseApiCall2] = await Promise.all([
        instance.post("insertPerson/", payloadPersona),
        //insertar otra llamada de api
      ]);
      //La otra respuesta 
      setIsLoading(false);
      if (!responseInsertPerson?.data /*|| !responseApiCall2?.data*/ ){
        console.log("Error, No hay data")
      }else{
        onCloseModal();
      }
    }catch(error){
      setIsLoading(false);
      console.log(error);

    }
  }
  
  const theme = createTheme();


  return (
    
      <Box
          
      sx={{
        ...style
      }}
    >
          <CssBaseline />
            <Avatar sx={{ m: 2, bgcolor: 'secondary.main' }}>
              <LockOutlinedIcon />
            </Avatar>
            <Typography component="h1" variant="h5">
              Registrarse
            </Typography>
            
            <Box component="form" noValidate sx={{ mt: 1 }}>
              
              <Grid container spacing={2}>
                <Grid item xs={6}>
                  <TextField
                    margin="normal"
                    required
                    fullWidth
                    id="nombre"
                    label="Nombre"
                    name="nombre"
                    value={persona.nombre}
                    onChange={handleInputChange}
                    autoComplete="nombre"
                    autoFocus
                  />
                </Grid>
                <Grid item xs={6}>  
                <TextField
                  margin="normal"
                  required
                  fullWidth
                  name="apellido"
                  value={persona.apellido}
                  onChange={handleInputChange}
                  label="Apellido"
                  type="apellido"
                  id="apellido"
                  autoComplete="apellido"
                />
                </Grid>
              </Grid>
              <Grid container spacing={3}>
                <Grid item xs={6}>
                  <TextField
                    margin="normal"
                    required
                    fullWidth
                    id="fechaNac"
                    label="Fecha de Nacimiento"
                    name="fechaNac"
                    value={persona.fechaNac}
                    onChange={handleInputChange}
                    autoComplete="fechaNac"
                    autoFocus
                  />
                </Grid>
                <Grid item xs={4}>  
                <TextField
                  margin="normal"
                  required
                  fullWidth
                  name="docIdent"
                  value={persona.docIdent}
                  onChange={handleInputChange}
                  label="Doc. de Identidad"
                  type="docIdent"
                  id="docIdent"
                  autoComplete="docIdent"
                />
                </Grid>
                <Grid item xs={1}>
                <InputLabel id="gender">Sexo</InputLabel>
                <Select
                  labelId="gender"
                  id="gender"
                  name="sexo"
                  value={persona.sexo}
                  onChange={handleInputChange}
                  label="sexo"
                >
                  <MenuItem value={"F"}>F</MenuItem>
                  <MenuItem value={"M"}>M</MenuItem>
                </Select>
                </Grid>
              </Grid>
              <Grid container spacing={2}>
                <Grid item xs={6}>
                  <TextField
                    margin="normal"
                    required
                    fullWidth
                    id="email"
                    label="Correo Electronico"
                    name="email"
                    autoComplete="email"
                    autoFocus
                  />
                </Grid>
                <Grid item xs={6}>  
                <TextField
                  margin="normal"
                  required
                  fullWidth
                  name="email2"
                  label="Repetir Correo"
                  type="email2"
                  id="email2"
                  autoComplete="email2"
                />
                </Grid>
              </Grid>
              <Grid container spacing={3}>
                <Grid item xs={4}>
                  <TextField
                    margin="normal"
                    required
                    fullWidth
                    id="password"
                    label="Contraseña"
                    name="password"
                    autoComplete="password"
                    autoFocus
                  />
                </Grid>
                <Grid item xs={4}>  
                <TextField
                  margin="normal"
                  required
                  fullWidth
                  name="password2"
                  label="Repetir Contraseña"
                  type="password2"
                  id="password2"
                  autoComplete="password2"
                />
                </Grid>
                <Grid item xs={1}>
                <InputLabel id="rol">Rol</InputLabel>
                <Select
                  labelId="rol"
                  id="rol"
                  value={rol}
                  label="rol"
                  onChange={handleRolChange}
                >
                  <MenuItem value={"admin"}>Administrador</MenuItem>
                  <MenuItem value={"database"}>Lo que sea base de dato</MenuItem>
                </Select>
                </Grid>
              </Grid>

              <Button 
                type="submit"
                fullWidth
                variant="contained"
                sx={{ mt: 3, mb: 2 }}
                onClick={handleSubmit}
                disabled={isLoading}
              >
                Registrarse
              </Button>
            </Box>

          </Box>
    );
  }

export default Register;