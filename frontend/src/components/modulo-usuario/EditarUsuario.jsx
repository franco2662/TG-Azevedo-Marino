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
import { FormControl, Modal } from '@mui/material';
import { useState } from 'react';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import Select, { SelectChangeEvent, selectClasses } from '@mui/material/Select';
import axios from 'axios';
import { useEffect } from 'react';
import { useAppContext } from "../../AppContext";


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


const EditarUsuario = ({ onCloseModal,IdUser }) => {
  const {baseURL} = useAppContext();
  const instance = axios.create()
  instance.defaults.baseURL = baseURL;
  const [isLoading, setIsLoading] = React.useState(false);
  const [gender, setGender] = React.useState('');
  const [usuario,setUsuario] = useState([]);
  
  async function getUser(){
      try {
          let response = await instance.get("getUserById/" + IdUser.userId);
          console.log(response);
          if (response?.data) {
            setUsuario(JSON.parse(response.data));
          }
      } catch (error) {
        console.log(error);
        throw new Error(error);
      } 
  }

  useEffect(() => {
    getUser();
  }, []);



  const handleSubmit = async (e) => {
   
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
        Editar Usuario
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
              id="clave"
              label="Contraseña"
              name="clave"
              autoComplete="clave"
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
          <Grid item xs={2}>
          
          <FormControl fullWidth>   
              <InputLabel id="rol">Rol</InputLabel>
              <Select
                //defaultValue='Select Rol'
                displayEmpty
                labelId="rol"
                id="select"
                label="Rol"
              >
                <MenuItem disabled value={null} >
                  <em>Select Rol</em>
                </MenuItem>
                
              </Select>
          </FormControl>     
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
          Guardar Cambios
        </Button>
      </Box>

    </Box>
  );
}

export default EditarUsuario;