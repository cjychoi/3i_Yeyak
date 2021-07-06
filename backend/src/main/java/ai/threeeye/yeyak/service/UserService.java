package ai.threeeye.yeyak.service;

import ai.threeeye.yeyak.domain.User;
import ai.threeeye.yeyak.resource.request.CreateUser;
import ai.threeeye.yeyak.resource.request.LoadUser;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mongodb.BasicDBObject;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.result.InsertOneResult;
import lombok.extern.slf4j.Slf4j;
import org.bson.Document;

import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.validation.Valid;
import java.util.Optional;
import java.util.UUID;

@Slf4j
@ApplicationScoped
public class UserService {

    @Inject
    private MongoClient mongo;
    @Inject
    private ObjectMapper om;

    private MongoCollection collection;

    @PostConstruct
    private void __INIT__() {
        this.collection = getCollection();
    }

    public User findByUsername(LoadUser payload) throws Exception {
        BasicDBObject query = new BasicDBObject();
        query.put("username", payload.getUsername());
        MongoCursor cursor = this.collection.find(query).iterator();
        if (!cursor.hasNext()) {
            throw new Exception("User not found");
        }

        return om.convertValue(cursor.next(), User.class);
    }

    public Boolean create(@Valid CreateUser payload) throws Exception {
        BasicDBObject query = new BasicDBObject();
        query.put("username", payload.getUsername());
        MongoCursor<User> cursor = this.collection.find(query).iterator();
        if (cursor.hasNext()) {
            throw new Exception("User already exists");
        }

        Document document = new Document()
                .append("_id", UUID.randomUUID().toString())
                .append("username", payload.getUsername());
        this.collection.insertOne(document);
        return true;
    }

    private MongoCollection<User> getCollection() {
        return mongo.getDatabase("yeyak").getCollection("users", User.class);
    }

}
