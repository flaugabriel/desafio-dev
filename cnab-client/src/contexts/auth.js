import { createContext, useEffect, useState } from "react";
import axios from 'axios';

export const AuthContext = createContext({});

const urlBase= 'http://localhost:3030/api/';

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState();
  const [status, setStatus] = useState('');

  useEffect(() => {
    const authorization = localStorage.getItem("authorization");
    const usersStorage = localStorage.getItem("users_bd");
    const hasUser = JSON.parse(usersStorage)?.filter(
      (user) => user.email === JSON.parse(authorization).email
    );

    if (authorization && usersStorage) {
      if (hasUser) setUser(hasUser[0]);
    }
  }, [])

  const signin = (email, password) => {
    axios({
      url: urlBase + 'auth/sign_in',
      method: "POST",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
      },
      data: { email: email, password: password },
    }).then((response) => {
      if (response.data.status === 404) {
        alert(response.data.errors[0]);
        setStatus('error')
      }else{
        localStorage.setItem("authorization", response.headers['authorization']);
        setUser({ email });
        alert('Bem vindo!');
      }
    }).catch(function (error) {
      alert(error.response.data.errors[0]);
      setStatus('error')
    });;
    return status;
  };

  const signup = (email, password, password_confirmation) => {
    axios({
      url: urlBase + 'auth',
      method: "POST",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
      },
      data: { email: email, password: password, password_confirmation: password_confirmation },
    }).then((response) => {
      if (response.data.status === 404) {
        alert('Verifique se o servidor esta disponivel ou tente mas tarde.');
      }else{
        alert('Cadastro realizado! \nPor favor realize o login!');

      }
    }).catch(function (error) {
      alert(error.response.data.errors.full_messages[0]);
    });;
    return;
  };

  const signout = () => {
    setUser(null);
    localStorage.removeItem("token_type");
    localStorage.removeItem("access_token");
    window.location = '/'
  };

  return (
    <AuthContext.Provider
      value={{ user, signed: !!user, signin, signup, signout }}
    >
      {children}
    </AuthContext.Provider>
  );
};