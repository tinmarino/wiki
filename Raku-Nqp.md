# Note Quite Perl


| QAST Node   | Description |
| ---         | --- |
| QAST::Block | A lexical scope |
| QAST::Stmts | A sequence of things to execute |
| QAST::Stmt  | As above, but also a temporaries boundary |
| QAST::Op    | An operation of some kind |
| QAST::Var   | A variable or parameter usage/declaration |
| QAST::IVal  | Integer literal |
| QAST::NVal  | Floating point literal |
| QAST::SVal  | String literal |
| QAST::BVal  | Block Value, refer to other block in the tree (dynamic) |
| QAST::WVal  | Refer to a var in the World Serialization Context |
| QAST::Want  | Permit to choose boxing accoring to type (context of identifyer) |
| QAST::VM    | Virtual Machine specific operation (discriminator) |

| P6opaque       | Opaque attribute storage; default in Perl 6 |
| P6int          | A native integer; flattens into a P6opaque |
| P6num          | A native float; flattens into a P6opaque |
| P6str          | A native string reference; flattens into a P6opaque |
| P6bigint       | Big integer; flattens into a P6opaque |
| VMArray        | Automatically resizing array, type-parametric |
| VMHash         | Hash table |
| Uninstantiable | Type object only; used for module, role, etc. |

The NQP iterator types for hashes that enable .key and .value methods are not yet set up, so this code uses nqp::iterkey s and nqp::iterval.

