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
import { useRef } from 'react';


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


const EditarUsuario = ({ onCloseModal,usuarioProp }) => {
  const {usuarioObjeto,baseURL} = useAppContext();
  const instance = axios.create()
  instance.defaults.baseURL = baseURL;
  const usuarioEdit = useRef(usuarioProp);


  //const initialStatePersona = { nombre: usuarioProp.fk_persona.nombre, apellido: "", fechanac: "", docidentidad: "", sexo: "" };
  const [persona, setPersona] = useState(usuarioProp.fk_persona);
  const initialStateUsuario = { email: usuarioProp.email, clave: "",clave2:"", fechacreacion: "", fk_rol: usuarioProp.fk_rol, fk_persona: usuarioProp.fk_persona, fk_empresa:usuarioProp.fk_empresa };
  const [usuario, setUsuario] = useState(initialStateUsuario);
  const [optionDataRoles, setOptionDataRoles] = useState([]);
  //Este es el seleccionado de Rol
  const [selectRol, setSelectRol] = useState("");
  const [optionDataEmpresas, setOptionDataEmpresas] = useState([]);
  //Este es el seleccionado de Rol
  const [selectEmpresa, setSelectEmpresa] = useState("");

  const handleRolChange = (event) => {
    const { target: { value } } = event;
    console.log(event.target);
    setSelectRol(value);
    console.log(selectRol);
  };

  const handleEmpresaChange = (event) => {
    const { target: { value } } = event;
    console.log(event.target);
    setSelectEmpresa(value);
    console.log(selectEmpresa);
  };

  const getEmpresa = async () => {
    try {
      const response = await instance.get("empresas/");
      const empresasData = response?.data
      empresasData?.map((empresa) => {
        if (empresa.id = usuarioProp.fk_empresa.id)
        setSelectEmpresa(empresa);
      });
      setOptionDataEmpresas((_prevEmpresas) => empresasData)
    } catch (error) {
      console.log(error);
      throw new Error(error);
    } finally {
    }
  };

  const getRol = async () => {
    try {
      const response = await instance.get("roles/");
      const rolesData = response?.data
      rolesData?.map((rol) => {
        if (rol.id = usuarioProp.fk_rol.id)
          setSelectRol(rol);
      });
      setOptionDataRoles((_prevRoles) => rolesData);
    } catch (error) {
      console.log(error);
      throw new Error(error);
    } finally {
    }
  };

  const handleInputChange = (e) => {

    setPersona({ ...persona, [e.target.name]: e.target.value });

  };

  const handleInputUsuario = (e) => {

    setUsuario({ ...usuario, [e.target.name]: e.target.value });

  };

  function comparePassword(){
    if(usuario.clave.length<=5 || (usuario.clave !=usuario.clave2)){
      return usuarioProp.clave;
    }
    else{
      return usuario.clave;
    }
  }
  
  useEffect(() => {  
      console.log(usuarioProp);
      getEmpresa().then(() => {
        getRol();
      });      
  }, []);

  
  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      let user_password = comparePassword();

      const payloadPersona = {
        id:persona.id,
        nombre: persona.nombre,
        apellido: persona.apellido,
        docidentidad: persona.docidentidad.trim(),
        fechanac: persona.fechanac.trim(),
        sexo: persona.sexo
      }     

      const payloadUsuario = {
        id:usuarioProp.id,
        email: usuario.email,
        clave: user_password,
        fechacreacion: usuarioProp.fechacreacion,
        estado:usuarioProp.estado,
        fk_rol: selectRol.id,
        fk_persona: persona.id,
        fk_empresa: selectEmpresa.id
      }
      const responseModifyUser = await instance.post("modifyUser/", payloadUsuario);
      const responseModifyPerson = await instance.post("modifyPerson/", payloadPersona);

      if (!responseModifyPerson?.data || !responseModifyUser?.data) {
        console.log("Error, No hay data")
      } else {
        onCloseModal();
        window.location.reload();
      }
    } catch (error) {
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
              value={persona.nombre}
              onChange={handleInputChange}                        
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
              value={persona.apellido}
              onChange={handleInputChange}
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
              value={persona.fechanac}
              onChange={handleInputChange}
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
              value={persona.docidentidad}
              onChange={handleInputChange}
            />
          </Grid>
          <Grid item xs={1}>
            <InputLabel id="gender">Sexo</InputLabel>
            <Select
              labelId="gender"
              id="gender"
              name="sexo"
              label="sexo"
              value={persona.sexo}
              onChange={handleInputChange}
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
              value={usuario.email}
              onChange={handleInputUsuario}
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
              type="password"
              name="clave"
              autoComplete="clave"
              autoFocus
              value={usuario.clave}
              onChange={handleInputUsuario}
            />
          </Grid>
          <Grid item xs={4}>
            <TextField
              margin="normal"
              required
              fullWidth
              name="clave2"
              label="Repetir Contraseña"
              type="password"
              id="password2"
              autoComplete="password2"
              value={usuario.clave2}
              onChange={handleInputUsuario}
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
                value={selectRol}
                onChange={handleRolChange}
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
          
          <FormControl fullWidth>   
              <InputLabel id="empresa">Empresa</InputLabel>
              <Select
                //defaultValue='Select Rol'
                displayEmpty
                labelId="empresa"
                id="select"
                value={selectEmpresa}
                onChange={handleEmpresaChange}
                label="Empresa"
              >
                <MenuItem disabled value={null} >
                  <em>Select Empresa</em>
                </MenuItem>
                {
                  optionDataEmpresas?.map((empresa) => (
                    <MenuItem key={empresa?.id} value={empresa}>{empresa?.nombre}</MenuItem>
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
        >
          Guardar Cambios
        </Button>
      </Box>

    </Box>
  );
}

export default EditarUsuario;