document.addEventListener('DOMContentLoaded',() =>{
    const name_elm = document.getElementById('name');
    const button = document.getElementById('myButton');

    if (button) {
        button.addEventListener('click', (event) =>{
            fetch('/apiview',{
                method: 'GET'
            })
            .then(response => response.json())
            .then(data => {
                name_elm.textContent = data.message;
            })
            .catch(error =>{
                name_elm.textContent = 'エラーです 取得失敗しました。';
            })
        })
    };

});

alert(get_all('/apiview'))



function insert_to_DOM(dom_id,api_endpoint,inject_data_to_dom_as_callback){
    const targetDom = document.getElementById(dom_id);

    try {
        const response =  fetch(api_endpoint,{
            method: 'GET'
        }).then(data => data.json());
        
        inject_data_to_dom_as_callback(response,targetDom)
    } catch (error) {
        alert(error.message)
    };
}


function get_all(api_endpoint){
    try {
        const result =  fetch(api_endpoint,{
            method:'GET'
        }).then(data => data.json())
        const return_data =  result;
    } catch  (error) {
        alert(error.message)
        const return_data = ''
    } finally {
        return return_json
    };
}

