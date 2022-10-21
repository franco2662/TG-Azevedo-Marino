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
import { useAppContext } from "../AppContext";


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


const Register = ({ onCloseModal }) => {
  const {baseURL} = useAppContext();
  const instance = axios.create()
  instance.defaults.baseURL = baseURL;
  const [isLoading, setIsLoading] = React.useState(false);
  const [gender, setGender] = React.useState('');
  const handleGenderChange = (event: SelectChangeEvent) => {
    setGender(event.target.value);
  };

  const [optionDataRoles, setOptionDataRoles] = useState([]);
  //Este es el seleccionado de Rol
  const [selectRol, setSelectRol] = useState("");

  const handleRolChange = (event) => {
    const { target: { value } } = event;
    console.log(event.target);
    setSelectRol(value);
    console.log(selectRol);
  }

  useEffect(() => {
    const getRol = async () => {
      try {
        setIsLoading(true);
        const response = await instance.get("roles/");
        console.log(response);
        const rolesData = response?.data
        setOptionDataRoles((_prevRoles) => rolesData)
      } catch (error) {
        console.log(error);
        throw new Error(error);
      } finally {
        setIsLoading(false);
      }
    };
    getRol();
  }, []);

  const initialStatePersona = { nombre: " ", apellido: " ", fechaNac: " ", docIdent: " ", sexo: " " };
  const [persona, setPersona] = useState(initialStatePersona);
  const initialStateUsuario = { email: " ", clave: " ", fechacreacion: " ", fk_rol: " ", fk_persona: " " };
  const [usuario, setUsuario] = useState(initialStateUsuario);

  const handleInputChange = (e) => {

    setPersona({ ...persona, [e.target.name]: e.target.value });

  }

  const handleInputUsuario = (e) => {

    setUsuario({ ...usuario, [e.target.name]: e.target.value });

  }






  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      setIsLoading(true);
      const json_request = JSON.stringify(persona);

      const payloadPersona = {
        nombre: persona.nombre,
        apellido: persona.apellido,
        sexo: persona.sexo,
        docidentidad: persona.docIdent,
        fechanac: persona.fechaNac
      }

      

      const responseInsertPerson = await instance.post("insertPerson/", payloadPersona);

      const fechaActual = new Date();

      const fkpersona = await instance.get("fkperson/"+payloadPersona.docidentidad);

      const payloadUsuario = {
        email: usuario.email,
        clave: usuario.clave,
        fechacreacion: fechaActual.toLocaleString("en-CA", {
          year:'numeric',month:'2-digit',day:'2-digit'
        }),
        fk_rol: selectRol.id,
        fk_persona: fkpersona.data
      }

      const responseInsertUser = await instance.post("insertUser/", payloadUsuario);

      console.log(payloadPersona);
      console.log(payloadUsuario);


      setIsLoading(false);
      if (!responseInsertPerson?.data || !responseInsertUser?.data) {
        console.log("Error, No hay data")
      } else {
        onCloseModal();
      }
    } catch (error) {
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
              value={usuario.email}
              onChange={handleInputUsuario}
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
              value={usuario.clave}
              onChange={handleInputUsuario}
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
                value={selectRol}
                onChange={handleRolChange}
                label="Rol"
              >
                <MenuItem disabled value={null} >
                  <em>Select Rol</em>
                </MenuItem>
                {
                  optionDataRoles?.map((rol) => (
                    <MenuItem key={rol?.id} value={rol}>{rol?.nombre}</MenuItem>
                  ))
                }
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
          Registrarse
        </Button>
      </Box>

    </Box>
  );
}

export default Register;