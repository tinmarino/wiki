### Spring: Name the different modules of the Spring framework.

* Spring Context – for dependency injection.
* Spring AOP – for aspect oriented programming.
* Spring DAO – for database operations using DAO pattern
* Spring JDBC – for JDBC and DataSource support.
* Spring ORM – for ORM tools support such as Hibernate
* Spring Web Module – for creating web applications.
* Spring MVC – Model-View-Controller implementation for creating web applications, web services etc.

### Spring: List some of the important annotations in annotation-based Spring configuration.

* @Required
* @Autowired
* @Qualifier
* @Resource
* @PostConstruct
* @PreDestroy


### What are some of the important Spring annotations which you have used?

@Controller – for controller classes in Spring MVC project.

@RequestMapping – for configuring URI mapping in controller handler methods. This is a very important annotation, so you should go through Spring MVC RequestMapping Annotation Examples

@ResponseBody – for sending Object as response, usually for sending XML or JSON data as response.

@PathVariable – for mapping dynamic values from the URI to handler method arguments.

@Autowired – for autowiring dependencies in spring beans.

@Qualifier – with @Autowired annotation to avoid confusion when multiple instances of bean type is present.

@Service – for service classes.

@Scope – for configuring the scope of the spring bean.

@Configuration, @ComponentScan and @Bean – for java based configurations.

### What is the life-cycle of a servlet?

1. Servlet is loaded
2. Servlet is instantiated
3. Servlet is initialized
4. Service the request
5. Servlet is destroyed

### What is a servlet?

Java Servlet is server-side technologies to extend the capability of web servers by providing support for dynamic response and data persistence.

### association, Agregation, composition

* Association: teachers and students: is a relationship where all object have their own lifecycle and there is no owner.
* aggregation: Departement and teachers: a teacher has onl'y one department but if free department, teacher survives
* 

### Why Java is not 100% Object-oriented?

Java is not 100% Object-oriented because it makes use of eight primitive data types such as boolean, byte, char, int, float, double, long, short which are not objects.
