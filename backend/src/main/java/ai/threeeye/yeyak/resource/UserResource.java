package ai.threeeye.yeyak.resource;

import ai.threeeye.yeyak.common.response.Result;
import ai.threeeye.yeyak.common.response.ResultCode;
import ai.threeeye.yeyak.domain.User;
import ai.threeeye.yeyak.resource.request.LoadUser;
import ai.threeeye.yeyak.service.UserService;
import ai.threeeye.yeyak.resource.request.CreateUser;

import javax.inject.Inject;
import javax.validation.ConstraintViolationException;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;
import java.util.stream.Collectors;

@Path("/users")
public class UserResource {

    @Inject
    private UserService userService;

    @POST
    @Path("/login")
    public Response login(LoadUser payload) throws Exception {
        try {
            User user = userService.findByUsername(payload);

            return Response.ok(new Result(200, user)).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.NOT_FOUND).entity(new Result(404, ResultCode.USER_NOT_FOUND)).build();
        }
    }

    @POST
    @Path("/signup")
    public Response signup(CreateUser payload) {
        try {
            Boolean ok = userService.create(payload);

            return Response.noContent().entity(new Result(200, ok)).build();
        } catch (ConstraintViolationException e) {
            e.printStackTrace();
            return Response.status(Response.Status.BAD_REQUEST).entity(new Result(400, e.getConstraintViolations())).build();
        } catch (Exception e) {
            return Response.status(404).entity(new Result(404, ResultCode.USER_ALREADY_EXISTS)).build();
        }
    }

}
