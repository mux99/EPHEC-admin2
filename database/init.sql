USE `mysql`;
create table `users`(
    `id` INT NOT NULL,
    `name` VARCHAR(255)
);

INSERT INTO `users`(`id`, `name`)
VALUES(1, 'test'), (2, 'michel'), (3, 'jean');