import http from "./api.service";

export default class WorkingTimesService {
    get(userID) {
        return http.get('/workingtimes/users/' + userID)
    }
    create(userID, workingTime) {
        return http.post('/workingtimes/' + userID, workingTime)
    }
    get_all(userID,debut,fin){
        return http.get('/workingtimes/users/'+userID+'?start='+debut+'&end='+fin)
    }
    update(workingTimeID, workingTime) {
        return http.put('/workingtimes/' + Number(workingTimeID), workingTime)
    }
    delete(workingTimeID) {
        return http.delete('/workingtimes/' + Number(workingTimeID))
    }
}