import 'package:flutter/material.dart';
import 'package:lloydportfolio/data/contact/contact_model.dart';

const contacts = <ContactItem>[
  ContactItem(
    label: 'Email',
    value: 'jhonlloydval@gmail.com',
    icon: Icons.mail_outline_rounded,
    url: 'mailto:jhonlloydval@gmail.com',
  ),
  ContactItem(
    label: 'LinkedIn',
    value: '/in/jhonlloydvalencia',
    icon: Icons.business_center_rounded,
    url: 'https://linkedin.com/in/jhonlloydval',
  ),
  ContactItem(
    label: 'GitHub',
    value: '@jhonlloydval',
    icon: Icons.code_rounded,
    url: 'https://github.com/jhonlloydval',
  ),
  ContactItem(
    label: 'Facebook',
    value: '@jhonlloydval14',
    icon: Icons.facebook_rounded,
    url: 'https://facebook.com/jhonlloydval14',
  ),
  ContactItem(
    label: 'Instagram',
    value: '@jhonlloydval',
    icon: Icons.camera_alt_outlined,
    url: 'https://instagram.com/jhonlloydval',
  ),
  ContactItem(
    label: 'Phone',
    value: '+639695363836',
    icon: Icons.phone_outlined,
    url: 'tel:+639695363836',
  ),
];
