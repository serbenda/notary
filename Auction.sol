// Version de solidity del Smart Contract
// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.16;

// Informacion del Smart Contract
// Nombre: Subasta
// Logica: Implementa subasta de productos entre varios participantes

// Declaracion del Smart Contract - Auction
contract Auction{

    // ----------- Variables (datos) -----------
    // Información de la subasta

    // Antiguo/nuevo dueño de subasta
    address payable private _marketing;   
    address private _owner;     

    // registro de patentes
    mapping(address => address) public _registry; 

    // registro en whitelist
    mapping(address => bool) private _whitelist;

    // registro en blacklist
    mapping(address => bool) private _blacklist;

    // contador de registros de una persona
    mapping(address => uint) private _count;

    // contador de patentes global
    uint8 public _total; 

    // precio
    uint8 public _price;
 
    // Estado de la notaría
    bool private _activeContract;



    
    // ----------- Eventos (pueden ser emitidos por el Smart Contract) -----------
    event Status(string _message);

    event Result(string _message, uint8 _total);

    // ----------- Constructor -----------
    // Uso: Inicializa el Smart Contract - Auction con: description, precio y tiempo
    constructor(_marketing, _owner, _price ) {
        _marketing = _marketing;
        _owner = _owner;
        _total = 0;
        _price = _price;
        _activeContract = true;


        // Se emite un Evento
        emit Status("Notaria generada");
    }

    
    // ------------ Funciones que modifican datos (set) ------------

    // Funcion
    // Nombre: bid
    // Uso:    Permite a cualquier postor hacer una oferta de dinero para la subata
    //         El dinero es almacenado en el contrato, junto con el nombre del postor
    //         El postor cuya oferta ha sido superada recibe de vuelta el dinero pujado
    function register() public payable {
        if(msg.value != _price  || activeContract == false){
            salir();
        } else {

            // Que no este el hash registrado
            // que el usuario no este baneado
            // 





            if (msg.value > highestPrice && msg.value > basePrice){
                // Devuelve el dinero al ANTIGUO maximo postor
                highestBidder.transfer(highestPrice);
                
                // Actualiza el nombre y precio al NUEVO maximo postor
                highestBidder = payable(msg.sender);
                highestPrice = msg.value;
                
                // Se emite un evento
                emit Status("Nueva puja mas alta, el ultimo postor tiene su dinero de vuelta");
            } else {
                // Se emite un evento
                emit Status("La puja no es posible, no es lo suficientemente alta");
                revert("La puja no es posible, no es lo suficientemente alta");
            }
        }
    }


    //         transfiere el balance del contrato al propietario de la subasta 
    function salir() public{
        if (msg.value != _price)){
            // si el precio no es igual > !! < se devuelve la pasta
            // 
            // Finaliza la subasta
            emit Status("Has mandado mas pasta, se devuelve la transaccion ");

            // Pendiente ver funcion que devuelva la pasta
        
        } else {

           emit Status("el contrato no esta activo");

        }
        revert("La subasta esta activa");
    }
        
    transferir la patente
    añadir a blacklist
    sacar de blacklist
    modificar precio
    historico de owners de una obra


    struct {
        string hash pdf
        string 2hash (dni+nombre)
        address: account
    }
    

    transfer:

        - inputs:
            - string hash pdf
            - to desrinatario......

        - dueño wallet ¿¿ pendieng check???
        // como ver comprobacion



    // ------------ Funciones de panico/emergencia ------------

    // Funcion
    // Nombre: stopAuction
    // Uso:    Para la subasta y devuelve el dinero al maximo postor
    function stopAuction() public{
        require(msg.sender == originalOwner, "You must be the original OWNER");
        // Finaliza la subasta
        activeContract = false;
        // Devuelve el dinero al maximo postor
        if (highestBidder != address(0x0)){
            highestBidder.transfer(highestPrice);
        }
        
        // Se emite un evento
        emit Status("La subasta se ha parado");
    }
    
    // ------------ Funciones que consultan datos (get) ------------

    // Funcion
    // Nombre: getAuctionInfo
    // Logica: Consulta la description, la fecha de creacion y el tiempo de la subasta
    function getAuctionInfo() public view returns (string memory, uint, uint){
        return (description, createdTime, secondsToEnd);
    }
    
    // Funcion
    // Nombre: getHighestPrice
    // Logica: Consulta el precio de la maxima puja
    function getHighestPrice() public view returns (uint){
        return (highestPrice);
    }

    // Funcion
    // Nombre: getHighestBidder
    // Logica: Consulta el maximo pujador de la subasta
    function getHighestBidder() public view returns (address){
        return (highestBidder);
    }

    // Funcion
    // Nombre: getDescription
    // Logica: Consulta la descripcion de la subasta
    function getDescription() public view returns (string memory){
        return (description);
    }

    // Funcion
    // Nombre: getBasePrice
    // Logica: Consulta el precio inicial de la subasta
    function getBasePrice() public view returns (uint256){
        return (basePrice);
    }

    // Funcion
    // Nombre: getActiveContract
    // Logica: Consulta si la subasta esta activa o no
    function isActive() public view returns (bool){
        return (activeContract);
    }
    
}
