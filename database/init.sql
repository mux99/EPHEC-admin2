USE `mysql`;
CREATE USER 'dummy'@'localhost' IDENTIFIED BY 'dojgdf__&Ih69TDPaBHREFNqozg';
GRANT SELECT ON `toys` . * TO 'dummy'@'localhost';
create table `users`(
    `id` INT NOT NULL,
    `name` VARCHAR(255)
);

create table `toys`(
    `id` INT NOT NULL,
    `name` VARCHAR(255),
    `brand` VARCHAR(255),
    `price` FLOAT
)

INSERT INTO `users`(`id`, `name`)
VALUES(1, 'test'), (2, 'michel'), (3, 'jean');

INSERT INTO `toys`(`id`, `name`, `brand`, `price`)
VALUES(1, 'Plastic Gun', 'Nerf', 69.99), (2, 'Water Gun', 'Werf', 39.99), (3, 'Risk', 'Hasbro', 24.59)