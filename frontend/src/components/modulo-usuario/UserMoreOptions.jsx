import { useRef, useState } from 'react';
import { Link as RouterLink } from 'react-router-dom';
import { Menu, MenuItem, IconButton, ListItemIcon, ListItemText,Modal } from '@mui/material';
import { Container } from "@mui/system";
import MoreVertIcon from '@mui/icons-material/MoreVert';
import EditIcon from '@mui/icons-material/Edit';
import RuleIcon from '@mui/icons-material/Rule';
import axios from "axios";
import { useAppContext } from '../../AppContext';
import EditarUsuario from './EditarUsuario';

const UserMoreOptions = (userId)=> {

  const {baseURL} = useAppContext();
  const instance = axios.create()
  instance.defaults.baseURL = baseURL;
  const ref = useRef(null);
  const [isOpen, setIsOpen] = useState(false);  
  const [openEdit, setOpenEdit] = useState(false);

  async function updateUserState() {
    try {
      let response = await instance.post("updateUserStatus/"+userId.userId);
      if (response?.data)
        window.location.reload();
    } catch (error) {
      console.log(error);
      throw new Error(error);
    } 
  }

  const handleUpdateUser=()=>{
    updateUserState();
  }

  const openEditModal = () => {
    setOpenEdit(true);
  };

  const closeEditModal = () => {
    setOpenEdit(false);
  };

  return (
    <>
      <IconButton ref={ref} onClick={() => setIsOpen(true)}>
        <MoreVertIcon width={20} height={20} />
      </IconButton>

      <Menu
        open={isOpen}
        anchorEl={ref.current}
        onClose={() => setIsOpen(false)}
        PaperProps={{
          sx: { width: 200, maxWidth: '100%' },
        }}
        anchorOrigin={{ vertical: 'top', horizontal: 'right' }}
        transformOrigin={{ vertical: 'top', horizontal: 'right' }}
      >  
        <MenuItem component={RouterLink} to="#" sx={{ color: 'text.secondary' }} onClick={openEditModal}>
          <ListItemIcon>
            <EditIcon width={24} height={24} />
          </ListItemIcon>
          <ListItemText primary="Editar" primaryTypographyProps={{ variant: 'body2' }} />
        </MenuItem>
        <Modal open={openEdit} onClose={closeEditModal}>
          <Container><EditarUsuario onCloseModal={closeEditModal} IdUser={userId}></EditarUsuario></Container>
        </Modal>

        <MenuItem sx={{ color: 'text.secondary' }} onClick={handleUpdateUser}>
          <ListItemIcon>
            <RuleIcon width={24} height={24} />
          </ListItemIcon>
          <ListItemText primary="Cambiar Estado" primaryTypographyProps={{ variant: 'body2' }} />
        </MenuItem>

      </Menu>
    </>
  );
}

export default UserMoreOptions;
