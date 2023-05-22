import React, { useEffect, useState } from "react";
import useAuth from "../../hooks/useAuth";
import './styles.css';
import { delete_all } from '../../operations/cnabs'
import { upload } from '../../operations/cnabs'
import { index } from '../../operations/cnabs'

const authorization = localStorage.getItem("authorization");

const Home = () => {
  const [selectedFile, setSelectedFile] = useState(null);
  const { signout } = useAuth();
  const [cnabs, setCnabs] = useState([])
  const [isload, setIsload] = useState(true);

  const handleFileChange = (event) => {
    setSelectedFile(event.target.files[0])
  }

  const formatCurrency=(vlr)=>{
    const valorFormatado = Intl.NumberFormat('pt-br', {style: 'currency', currency: 'BRL'}).format(vlr)

    return valorFormatado;
  }

  const handleSubmit = (event) => {
    event.preventDefault();
    if (selectedFile) {
      const formData = new FormData();
      formData.append('file', selectedFile);

      upload(formData, authorization).then((response) => {
        if (response.data.status === 404) {
          console.log(response.data.errors[0]);
        }else{
          setCnabs(response.data.message)
          setIsload(true)
        }
      }).catch(function (error) {
        console.log('upload', error);
      });
    }
  }

  const CleanCnabs = () =>{
    delete_all(authorization).then((response) => {
      if (response.data.status === 404) {
        console.log(response.data.errors[0]);
      }else{
        setCnabs([])
        alert(response.data.message);
      }
    }).catch(function (error) {
      console.log('delete_all', error);
    });
  }

  useEffect(() => {
    index(authorization).then((items) => {
      if (items.data.length !== undefined) {
        console.log(items.data);
        setIsload(false)
        setCnabs(items.data)
      }
    });
  },[isload]);

  return (
    <>
      <header className="space-custon">
        <nav className="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
          <div className="container-fluid">
            <a className="navbar-brand" href="/">DESAFIO DEV</a>
            <div className="collapse navbar-collapse" id="navbarCollapse">
              <ul className="navbar-nav me-auto mb-2 mb-md-0"></ul>
              <form className="d-flex">
                <input className="form-control me-2" type="search" placeholder={'flaugabriel@gmail.com'} aria-label="Search" disabled />
                <button className="btn btn-danger" onClick={() => signout()} type="submit">Sair</button>
              </form>
            </div>
          </div>
        </nav>
      </header>
      <main className="flex-shrink-0 ">
        <div className="container ">
          <h1 className="mt-5">Realize o upload do arquivo de CNAB</h1>
          <form onSubmit={handleSubmit}>
            <div className="row">
              <div className="col-md-6">
                <input
                  type="file"
                  className="form-control"
                  onChange={handleFileChange}
                />
              </div>
              <div className="col-md-6">
                <button type="submit" className="btn btn-success me-3">
                  Salvar
                </button>
                <button type="submit" className="btn btn-danger me-3" onClick={CleanCnabs}>
                  Limpar CNAB
                </button>
              </div>
            </div>
          </form>
        </div>
        <div className="space-custon">
          <table className="table table-hover ">
            <thead>
              <tr>
                <th>Usuário</th>
                <th>Tipo</th>
                <th>Data da ocorrencia</th>
                <th>Valor</th>
                <th>Cpf</th>
                <th>Cartão</th>
                <th>Hora</th>
                <th>Dono da loja</th>
                <th>Nome da loja</th>
                <th>Ultima transação</th>
                <th>Balanço Total</th>
              </tr>
            </thead>
            <tbody>
              {cnabs && cnabs.length > 0 ? (
                cnabs.map((cnab) => (
                  <tr key={cnab.id}>
                    <td>{cnab.user.email}</td>
                    <td>{cnab.type_cnabs}</td>
                    <td>{cnab.date_occurrence}</td>
                    <td>{formatCurrency(cnab.value)}</td>
                    <td>{cnab.user.cpf}</td>
                    <td>{cnab.card}</td>
                    <td>{cnab.hours}</td>
                    <td>{cnab.store.store_owner}</td>
                    <td>{cnab.store.store_name}</td>
                    <td>{cnab.deal.nature}</td>
                    <td>{formatCurrency(cnab.store.balance_total)}</td>
                  </tr>
                ))) : (<span>Não foi encontrado nenhuma CNAB</span>)}
            </tbody>
          </table>
        </div>
      </main>
    </>
  );
};

export default Home;